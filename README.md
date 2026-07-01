# End-to-End CI/CD Pipeline & IaC Project

Bu proje, bir web uygulamasının altyapısının kodla (IaC) kurulmasını, Dockerize edilmesini ve GitHub Actions kullanılarak AWS üzerinde tamamen otomatik bir şekilde canlıya alınmasını (CI/CD) kapsayan temel bir DevOps pratik projesidir.

##  Kullanılan Teknolojiler
* **Uygulama:** Node.js (Express.js)
* **Altyapı (IaC):** Terraform
* **Konteynerleştirme:** Docker & Docker Hub
* **CI/CD Pipeline:** GitHub Actions
* **Bulut Sağlayıcı:** AWS (VPC, Subnet, EC2, Security Group)

##  Proje Mimarisi & Akış Şeması
1. **Infrastructure as Code:** AWS üzerinde VPC, Public Subnet, Internet Gateway ve Security Group bileşenleri Terraform ile sıfırdan oluşturuldu. Uygulama, güncel Free Tier limitlerine uygun bir `t3.micro` EC2 (Ubuntu) instance üzerinde ayağa kaldırıldı.
2. **Dockerization:** Node.js uygulaması `node:18-alpine` tabanlı hafif bir imaj olarak paketlendi ve `.dockerignore` ile optimize edildi.
3. **Continuous Integration (CI):** `main` branch'ine yapılan her push işleminde GitHub Actions tetiklenerek Docker imajını build eder ve Docker Hub reposuna otomatik olarak pushlar.
4. **Continuous Deployment (CD):** CI aşaması başarıyla tamamlandığında, GitHub Actions SSH (`appleboy/ssh-action`) protokolü ile AWS EC2 sunucusuna güvenli bir şekilde bağlanır. Sunucudaki eski konteyneri temizler, yeni imajı çeker ve sıfır kesinti hedefiyle uygulamayı `3000` portundan canlıya alır.

##  Proje Yapısı
```directory
hello-devops-project/
├── .github/workflows/
│   └── deploy.yml          # GitHub Actions Pipeline tanımları
├── terraform/
│   ├── providers.tf        # AWS Provider konfigürasyonu
│   ├── vpc.tf              # Ağ (Network) altyapı kodları
│   └── main.tf             # EC2 ve Security Group tanımları
├── app.js                  # Node.js Web Sunucu kodu
├── Dockerfile              # Uygulama paketleme talimatları
├── .gitignore              # Git tarafından takip edilmeyecek dosyalar (.tfstate vb.)
└── .dockerignore           # Docker imajına dahil edilmeyecek dosyalar