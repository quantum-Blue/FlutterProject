## Favori Kitaplar Uygulaması


## Kullanıcı Bilgileri

Kullanıcı adı: admin
Şifre: 1234

## Proje Açıklaması

Bu Flutter uygulaması, kullanıcıların kitapları internetten arayıp listelemesini
ve favori kitaplarını kalıcı olarak saklamasını sağlar.
Kullanıcılar login olduktan sonra uygulamaya giriş yapabilir, kitap arayabilir, 
kitapları favorilere ekleyip çıkarabilir.

---

## Sayfalar ve Görevleri

## `LoginPage`
- Kullanıcı adı ve şifre girilerek giriş yapılır.
- Girişten sonra `HomePage`'e yönlendirilir.

## `HomePage`
- Google Books API'den alınan kitaplar listelenir.
- Kullanıcılar arama kutusuyla kitap arayabilir.
- Kitaplar favorilere eklenebilir ya da çıkarılabilir.
- AppBar’da “Kitaplar” başlığı bulunur.
- Drawer menüsü içerir.

## `FavoritesPage`
- Kullanıcının favori olarak işaretlediği kitaplar listelenir.
- Her kitabın yanında “sil” butonu ile favoriden kaldırma yapılabilir.
- AppBar’da “Favori Kitaplar” başlığı bulunur.
- Drawer menüsü içerir.

---

## Drawer Menüsü ve Logo API Bilgisi

- Drawer header içinde logo gösterilir.
- Logo internetten API ile alınır.

## Kullanılan Logo API:

-https://dog.ceo/api/breeds/image/random
- API'den rastgele bir köpek resmi gelir.
- Bu resim `Image.network()` ile drawer'da gösterilir.

---

## Login Bilgileri

- Login ekranında kullanıcı adı ve şifre girilir.
- Gerçek bir doğrulama yoktur, doğrudan `HomePage`'e geçilir.

---

## Favori Kitapların Saklanması

- Favoriler `shared_preferences` paketi ile cihazda **kalıcı** olarak saklanır.
- Uygulama kapatılsa bile favoriler korunur.

---

## Grup Üyeleri ve Katkılar

- Bu proje, tüm sayfalar ve işlevler
- Emir Buğra Dikiz
- Muhammed Enes Bal
- Furkan Akın
- tarafından yapılmıştır


## Diğer Özellikler

- Gerçek zamanlı kitap arama özelliği (Google Books API)
- İnternet üzerinden dinamik logo gösterimi
- AppBar ve Drawer menüsü
- Modüler kod yapısı (her sayfa ayrı `.dart` dosyasında)
- Kalıcı veri yönetimi (`shared_preferences`)
- Responsive ve kullanıcı dostu tasarım

---

## Uygulamayı Çalıştırmak İçin

1. Gerekli paketleri yükleyin:

- flutter pub get
2. AndroidManifest.xml dosyasına internet izni eklediğinizden emin olun:
- "<uses-permission android:name="android.permission.INTERNET"/>"

3. Uygulamayı başlatın:
- flutter run