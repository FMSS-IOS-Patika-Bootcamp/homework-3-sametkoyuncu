# Ödev 3 | Penguin App

> [Simülatör açılmıyorsa lütfen bu dosyaya bakınız. 👆](https://github.com/FMSS-IOS-Patika-Bootcamp/homework-3-sametkoyuncu/blob/main/SchemeFixer.md)

FMSS Bilişim & Patika iOS Bootcamp'inin üçüncü ödevi olarak yaptığım `Penguen` isimli uygulama.

Uygulama üç farklı bölümden oluşuyor:
1. bölüm, api'den gelen yazı verilerinin, başlık ve içerik olarak `UITableView` ile gösterildiği kısım.
2. bölüm, api'den gelen görsellerin `UICollectionView` ile gösterildiği kısım.
3. bölüm, CoreData ile todo list uygulaması.
    - Kullanıcı listeye yeni eleman ekleyebiliyor.
    - Listede var olan elemanı, `tamamlandı` veya `tamamlanmadı` şeklinde güncelleyebiliyor.
    - İstediği elemanı silebiliyor.
    
## Kullanılanlar
- Table View (Custom TableViewCell using .xib file)
- Collection View (Custom CollectionViewCell using .xib file)
- TabBar
- Delegation Pattern
- MVVM
- CoreData
- URLSession
- KingFisher

## Ekran Görüntüleri
- 'Posts' ekranı, api'den gelen veriler gösteriliyor.
<img src="https://github.com/FMSS-IOS-Patika-Bootcamp/homework-3-sametkoyuncu/blob/main/screenshots/blue%20phone%20bg.png" />

- 'Gallery' ekranı, api'den gelen veriler gösteriliyor.
<img src="https://github.com/FMSS-IOS-Patika-Bootcamp/homework-3-sametkoyuncu/blob/main/screenshots/pink%20phone%20bg.png" />

- 'Todo' ekranı, eleman ekleme ve güncelleme bildirimleri. (2 sn. sonra kendiliğinden kayboluyor. Veya buton ile kapanabiliyor.)
<img src="https://github.com/FMSS-IOS-Patika-Bootcamp/homework-3-sametkoyuncu/blob/main/screenshots/yellow%20phone%20bg%201.png" />

- Yeni eleman ekleme ekranı (solda), eleman detay ekranı (sağda).
<img src="https://github.com/FMSS-IOS-Patika-Bootcamp/homework-3-sametkoyuncu/blob/main/screenshots/yellow%20phone%20bg%202.png" />
