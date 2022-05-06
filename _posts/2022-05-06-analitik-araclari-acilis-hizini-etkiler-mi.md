---
layout: post
title:  "Analitik araçları sitelerin açılış hızını etkiliyor mu?"
tags: [ kaynak, embargo ]
image: assets/images/mac-screen.jpg
description: Analitik araçları, web sitelerinin en önemli metriklerinden birisi olan açılış hızını etkiliyor mu? Etkilememesi için neler yapmalısınız? Detaylarıyle beraber kaleme aldım.
---
Arama sonuçlarında iyi bir yer elde etmek için artık içeriğin gücünün yanı sıra kullanıcıya sunduğunuz deneyim de oldukça önemli. Bu noktada Core Web Vitals metriklerini baz almak oldukça önemli. Bu metriklerden en önemlileri arasında site açılış hızı yer alıyor.

Web sitenizdeki etkinlikleri takip edebilmek için ise analitik araçları oldukça önemli bir yer kaplıyor, takip verilerinin doğru çalışması için mümkün olduğunda üstte yer alması tavsiye ediliyor. Sayfa yüklenme işlemi bildiğiniz gibi bir kağıt okurken nasıl tepeden aşağıya iniyorsak aynı o şekilde gerçekleşyor. İşte burada üçüncü parti takip araçlarının araya girmesi yüklenme sürecini temelde etkileyebiliyor.

## Senkron (eşzamanlı) ve Asenkron (eşzamansız) yükleme nedir?

Aslında bunu yalnızca analitik araçları ile sınırlamak pek de adil olmayacaktır, farklı bir JavaScript kodu da buna neden olabilir. İşte bu yüzden eklediğiniz üçüncü parti JavaScript araçlarını sitenize eklerken eşzamansız olarak yüklenmesine önem göstermelisiniz. Eğer eşzamanlı ve eşzamansız JavaScript yüklenmesi hakkında bilginiz yoksa izin verin açıklayayım;
*Eşzamanlı kod* ile yüklenme işlemi birer birer gerçekleşir, yani bir önceki yüklenme işlemi tamamlanmadan sonraki JavaScript yüklenmez. Bu da belgelerin tek tek indirilmesine ve açılış hızına olumsuz etkiye dönüşür.

*Eşzamansız kod* ile yükleme işlemi, bir önceki işlem bitmeden başlayabilir. Bu sayede birden fazla işlemi aynı anda gerçekleştirebilir ve daha fazla işlemi aynı anda tamamlayabilirsiniz.

Mevcut olarak ücretsiz analitik araçlarından en popülerleri [Google Anaytics](https://analytics.google.com), [Yandex.Metrica](https://metrica.yandex.com) ve [Microsoft Clarity](https://clarity.microsoft.com). Bunların haricinde ücretli olarak hizmet veren  [Hotjar](https://hotjar.com), [Piwik](https://piwik.pro), [Matomo](https://matomo.org) ve [Plausible](https://plausible.io) var. Ücretsiz servisler elbette size bu hizmetleri ücretsiz verirken aslında sizin misafirlerinizin oluşturduğu veriyi paraya dönüştürebildiği için hizmet sağlıyor. Diğer durumda gizlilik veya daha çeşitli konulara eğilen analitik araçları ücretsiz alternatiflerine göre daha hafifler. Hafif olmaları nedeniyle de sitenizin performansına ciddi anlamda yüklenmiyorlar. Bu tabi ki Google Analytics veya bir diğerini kullanmayı bırakıp ücretli bir servise geçin demek değil, ancak göz atmakta fayda olacaktır.

## Hangi ücretsiz analitik araçlarını tercih etmeliyim?
Açıkçası elinizdeki veri kaynağı ne kadar çok olursa o kadar iyi, böylece kaynaklarınızın doğruluğunu ve ne kadar iyi ölçüm yapabildiklerini test etme imkanınız olur. Oluşturacağınız projeye göre ilerde bazılarını elemeye başlayabilirsiniz. Ancak entegrasyon açısından Google Analytics ve Microsoft Clarity duruma farklı bir boyut kazandırıyor.

Microsoft'un çok da bilinir olmayan bu analitik hizmeti, sahip olduğu Google Analytics ile gelişmiş entegrasyon desteği sayesinde çift taraflı veri iletimi geçekleştirebiliyor. Bu da Google Analytics'teki verilerinize Microsoft Clarity'den erişebilmenize, kısmi Microsoft Clarity verilerinize de Google Analytics üzerinden erişme imkanı sunuyor.

Üstelik yazının özüne dönecek olursak bu üç popüler ücretsiz analitik servisinin arasında Microsoft Clarity en hafif performansı gösteren araç. Verileri paylaşmak gerekirse aşağıdan bulabilirsiniz.

| Web Sitesi | Konum | Günlük oturum | Toplam engelleme süresi (ms) | Uzun Görevler | İndirilen komut dosyası boyutu (byte) |
|------------|---------------|-----------|--------------------|--------------|----------|
| Çevrimiçi Bankacılık | Brezilya | 0.6m | 0 | 0 | 25113 |
| Hava Durumu | Brezilya | 1.2m | 0 | 0 | 25741 |
| Çevrimiçi Bankacılık | Arjantin | 0.3m | 0 | 1 | 25639 |
| Müzik Paylaşımı | Güney Kore | 0.1m | 0 | 2 | 25962 |
| Araç Kiralama | Çek Cumhuriyeti | 0.1m | 0 | 1 | 25218 |

_[Kaynak belge](https://clarity.microsoft.com/blog/does-clarity-affect-website-performance/)_

### Google Analytics ve Microsoft Clarity entegrasyonu neler sunuyor?
Google Analytics, veri anlamında her ne kadar çeşitli ve zengin içerik sunsa da verileri anlamlandırmanız için uzmanlık istiyor. Bu durum profesyoneller için her ne kadar iyi olsa da Analytics'e hakim olmayanlar için tanımlandırmamız bir dizi ham veri hiçbir anlam ifade etmeyecektir. İşte bu noktada Microsoft Clarity, size işinize yarayabilecek temel verileri olabildiğince açık bir şekilde sunuyor.

Örnek vermek gerekirse web sitenizde yer alan makalelerin (veya içeriğin) okunma durumunu tarayıcılar veya cihaz türlerine göre karşılaştırmak istiyorsunuz diyelim. Normalde elinizde ham bir veri olduğunda bunu sayfadaki kaydırma ve geçirdikleri süre, aynı zamanda platform ve tarayıcıyı dahil ederek anlamlandırmanız gerekiyor. İşte burada Clarity size bazı öne çıkan verileri otomatik olarak anlamlandırıp sunuyor.

Anlamlandırılmış verilerden örnek vermek gerekirse "Chrome'dan gelen ziyaretçilerin bir makaleyi baştan sona okuduğu oturumlara sahip olma olasılığı Chrome Mobile'daki kullanıcılara kıyasla 3.5 kat daha fazladır"
. İşte, gördüğünüz tek mesaj bu, ama bunun arkasında pek çok veri yer alıyor. Bunların arasında okuyucuları gündelik veya ciddi olarak sınıflandırma veya farklı parametreler de yer alıyor. 

#### Clarity'nin derinliklerine dalmak
Her ne kadar Clarity bir analitik aracı olsa da tek işi bu değil. Bunun haricinde özellikle UI/UX geliştiricileri için oturum kayıtları, tık ve ısı haritaları gibi pek çok veri kaynağını da sunuyor. Bunları pek çoğunuz daha önce Hotjar veya Yandex.Metrica ile kullanmışsınızdır eminim ancak ücretsiz bir alternatif olan Clarity'nin yeteneklerine de göz atmak isteyeceksiniz. Şimdi birkaç başlık üzerinden incelemeye devam edelim.