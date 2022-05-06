---
layout: post
title:  "Analitik araçları sitelerin açılış hızını etkiliyor mu?"
tags: [ kaynak, microsoft ]
image: assets/images/analytic.jpg
description: Analitik araçları, web sitelerinin en önemli metriklerinden birisi olan açılış hızını etkiliyor mu? Etkilememesi için neler yapmalısınız? Detaylarıyla beraber kaleme aldım.
---
Arama sonuçlarında iyi bir yer elde etmek için artık içeriğin gücünün yanı sıra kullanıcıya sunduğunuz deneyim de oldukça önemli. Bu noktada Core Web Vitals metriklerini baz almanız gerekiyor. Bu metriklerden en önemlileri arasında site açılış hızı yer alıyor.

Web sitenizdeki etkinlikleri takip edebilmek için ise analitik araçları oldukça önemli bir yere sahip, takip verilerinin doğru çalışması için mümkün olduğunca üstte yer alması tavsiye ediliyor. Sayfa yüklenme işlemi bildiğiniz gibi bir kağıt okurken nasıl tepeden aşağıya iniyorsak aynı o şekilde gerçekleşyor. İşte burada üçüncü parti takip araçlarının araya girmesi yüklenme (toplam) süresini temelde etkilemekte.

## Senkron (eşzamanlı) ve Asenkron (eşzamansız) yükleme nedir?

Aslında bunu yalnızca analitik araçları ile sınırlamak pek de adil olmayacaktır, üçüncü parti bir JavaScript kodu da buna neden olabilir. İşte bu yüzden eklediğiniz üçüncü parti JavaScript araçlarını sitenize eklerken eşzamansız olarak yüklenmesine önem göstermelisiniz. Eğer eşzamanlı ve eşzamansız JavaScript yüklenmesi hakkında bilginiz yoksa izin verin açıklayayım;

**Eşzamanlı kod** ile yüklenme işlemi birer birer gerçekleşir, yani bir önceki yüklenme işlemi tamamlanmadan sonraki JavaScript yüklenmez. Bu da belgelerin tek tek indirilmesine ve açılış hızına olumsuz etkiye dönüşür.

**Eşzamansız kod** ile yükleme işlemi, bir önceki işlem bitmeden başlayabilir. Bu sayede birden fazla işlemi aynı anda gerçekleştirebilir ve daha fazla işlemi aynı anda tamamlayabilirsiniz ve kod hemen çalışmaya başlar.

**Ertelemeli kod** ile (async olmadan) JavaScript ile sayfa paralel olarak iner ve sayfa tamamen yüklendikten sonra çalışmaya başlar.

**Hiçbiri yoksa** ile (asnyc ve defer) komut dosyaları iner, hemen çalışır, ama komut dosyası inene kadar bir sonraki öğenin yüklenmesini engeller.

Örnek JavaScript kodu:
```
<script src="ornek.js"></script>
```

Eşzamansız JavaScript kodu:
```
<script src="async_ornek.js" async></script>
```

Mevcut olarak ücretsiz analitik araçlarından en popülerleri [Google Anaytics](https://analytics.google.com), [Yandex.Metrica](https://metrica.yandex.com) ve [Microsoft Clarity](https://clarity.microsoft.com). Bunların haricinde ücretli olarak hizmet veren  [Hotjar](https://hotjar.com), [Piwik](https://piwik.pro), [Matomo](https://matomo.org) ve [Plausible](https://plausible.io) var. Ücretsiz servisler elbette size bu hizmetleri ücretsiz verirken aslında sizin misafirlerinizin oluşturduğu veriyi paraya dönüştürebildiği için hizmet sağlıyor. Diğer durumda gizlilik veya daha çeşitli konulara eğilen analitik araçları ücretsiz alternatiflerine göre daha hafifler. Hafif olmaları nedeniyle de sitenizin performansına ciddi anlamda yüklenmiyorlar. Bu tabi ki Google Analytics veya bir diğerini kullanmayı bırakıp ücretli bir servise geçin demek değil, ancak göz atmakta fayda olacaktır.

Eğer asenkron yükleme ile ilgili teknik detaylarla uğraşmak istemiyorsanız [Google Tag Manager](https://tagmanager.google.com/#/home) kullanabilirsiniz. GTM, varsayılan olarak JavaScript'leri asnyc olarak yükler, böylece sizin herhangi bir düzenleme yapma ihtiyacınız ortadan kalkar. Google Tag Manager'ın kendisi eşzamansız olduğu için çektiği tüm JavaScript'ler de buna bağlı olarak yüklenir.

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

![Microsoft Clarity ve Google Analytics](/assets/images/clarity-analytics.jpg)

#### Clarity'nin derinliklerine dalmak
Her ne kadar Clarity bir analitik aracı olsa da tek işi bu değil. Bunun haricinde özellikle UI/UX geliştiricileri için oturum kayıtları, tık ve ısı haritaları gibi pek çok veri kaynağını da sunuyor. Bunları pek çoğunuz daha önce Hotjar veya Yandex.Metrica ile kullanmışsınızdır eminim ancak ücretsiz bir alternatif olan Clarity'nin yeteneklerine de göz atmak isteyeceksiniz. Şimdi birkaç başlık üzerinden incelemeye devam edelim.

##### Isı haritaları
Sitenizi ziyaret eden kullanıcıların davranışlarını kontrol etmek önemlidir. Her ne kadar küçük işletmeler ve yeni başlayanlar için pek bir anlam ifade etmese de profesyonelliğe atılan ilk adımlardan birisi misafirlerinizi takip etmek ve onların nerelerde takıldığını analiz etmektir. Sadece bu amaçla değil, A/B testlerinizin başarılılığını da takip etmeniz açısından bir sonuç sunabilir. Isı haritaları farklı öğelere ayrılmakta, bu sayede farklı bilgileri edinmek için farklı haritalara göz atabilirsiniz.

###### Tıklama haritası
Bu harita tipi misafirlerinizin sayfada nerelere tıklama yaptığını gösterir. Bu sayede call-to-action butonunuza talep olup olmadığını veya makalenizde yer alan bağlantılardan en çok hangileri ile etkişime geçildiği, en çok hangi sayfalara atlama yapıldığını görsel olarak görebilirsiniz. Sayfada yer alan rage tıklamalar, ölü tıklamalar ve benzeri öğeleri tespit etmenize de olanak sağlar.

- **Tüm tıklamalar** kullanıcıların sayfada tıkladığı yeri gösterir
- **Kullanım dışı tıklamalar** etkisi olmayan bir sayfadaki tıklamaları gösterir
- **Aralık tıklamalar** aynı alanda yinelenen tıklamaları göster, sinirliliği gösterir
- **İlk tıklamalar** sayfadaki ilk tıklama eylemlerinin toplamını gösterir
- **Son tıklamalar** sayfadaki son tıklama eylemlerinin toplamını gösterir

###### Kaydırma haritası
Aslında başlık yeterince açık, yine de ifade etmek gerekirse; ziyaretçilerin sayfanın ne kadar derinine gittiğini tespit etmenizi sağlayan bir araçtır. Eğer sayfanızda bir makale varsa kullanıcıların ne kadarının, nereye kadar tutku ile okumaya devam ettiğini göremenize olanak tanır. Bir landing page'iniz varsa misafirlerinizin nereye kadar bilgilere göz atma eğilimi gösterdiğini görmenize imkan sağlar ve sayfa şablonunu bu yönde optimize etmenize olanak tanır.

###### Alan haritası
Temelde size tıklama haritası ile aynı şeyleri gösterir, ama tüm sayfayı değerlendirmek yerine seçtiğiniz alandaki değerleri sunar. Yine özellikle UI/UX çalışmak için önemli bir araçtır. Örneğin web siteniz iki kolonlu; bir kolonda metin içeriği yer alıyor, diğer kolonda faydalı bağlantılar ve bazı araçlar... Eğer siz faydalı bağlantılar ve bazı araçların olduğu alanı iyileştirmek ve burası ile ilgili metriklere erişmek istiyorsanız alan haritası size doğrudan bunu sunar.

##### Oturum kayıtları
Oturum kayıtlarının mantığı oldukça basittir, kullanıcın sayfadaki deneyimini birebir takip etmenizi sağlar. Sayfayı önceden ziyaret etmiş olan misafirin imleç hareketlerini ve form alanları ile etkileşime geçme verilerini doğrudan kaydeden bu özellik, size misafirin hassas bilgilerini iletmeden tekrar izleme fırsatı sunar. Bu sayede çalışmayan veya kullanıcı deneyimini olumsuz etkileyen durumları kolayca tespit etmeniz mümkün hale gelir. Yine burada rage tıklamalar, ölü tıklamalar gibi filtreleri kullanmak mümkün. Bu sayede doğrudan çözmek istediğiniz sorunları hızlıca tespit edebilir ve bu konular üzerine yoğunlaşabilirsiniz. Bu konuda Clarity'nin hakkını yememek gerekiyor, sunduğu 25'ten fazla filtre ile size nokta atışı sorunları tespit etmenizde büyük rol üstleniyor. Bu alanın Google Analytics ile entegrasyonu olduğunu da söylemek artı olacaktır.

##### İçgörüler
Kullanıcı deneyimini etkileyen belli başlı konular vardır. Bunlara aslında yazının daha önceki kısımlarında biraz değinmiş olduk; rage (tekrar tekrar) tıklamalar, ölü (geçersiz) tıklamalar ve mevcut sayfadan hızlıca önceki sayfaya dönmek. Bunlar, sayfanızı ziyaret eden kişinin aradığını bulamama veya daha fazlasına ihtiyaç duyduğunu gösteren bazı metrikler. 

Bir de bunların haricinde teknik hatalar olabiliyor. İçgörüler bu konuda da yardımcı oluyor, JavaScript veya görsel hatalar meydana geldiğinde bunları, sistem üzerinde yer alan filtreleri kullanarak kolayca tespit edebiliyor ve hatanın nerede meydana geldiğini buluyorsunuz. Ardından çözmek elbette size kalıyor tabi. Yine de araştırma ve tespit adımlarını Clarity sizin için o kadar hızlandırıyor ki, kritik hataları bile kolayca tespit etmenize olanak sağlıyor.

##### Google Analytics entegrasyonu
Microsoft Clarity'nin iyi bir araç olsa da ham veri açısından Google Analytics ile karşılaştırılmaması gerektiğinden yazının önceki kısımlarında bahasettim. Servisin eksik kısmını bilmek güzel, ancak onu güçlendirmek de sizin elinizde. Hali hazırda Google Analytics kullanıyorsanız, sitenize ait Analytics verileri ile Clarity'i zenginleştirmeniz de bir o kadar kolay. Tek yapmanız gereken Clarity içerisinden Google Analytics hesabınızı ilişkilendirmeniz. Üstelik bu entegrasyon tek yönlü değil, çift yönlü çalışıyor.

Google Analytics'te oluşturduğunuz bir segment grubunun sitenizdeki davranışlarını takip etmek istiyorsanız, Clarity içerisindeki Kayıtlar sayfasından ilgili segmentin sonuçlarını görüntüleyebilirsiniz. Bu sayede hedef kitlenize yönelik iyileştirmeler ve hata tespitleri üzerinde çalışmanız mümkün olur.

Bu entegrasyon sayesinde yalnızca Google Analytics verilerini Microsoft Clarity'e değil, aynı zamanda Clarity verilerini Analytics'e de aktarmış oluyorsunuz. Örnek vermek gerekirse Universal Analytics kullandığınız bir mülkte Davranışlar altından Clarity'nin oturum kayıtlarına doğrudan erişebilirsiniz.

Clarity'nin Google Analytics entegrasyonu ile yaptığı tek şey bunlarla sınırlı değil. Google Analytics ile toplanmış hedef kitlenize genel bakış, popüler sayfalarınız, ülke ve cihaza göre oturumları da Clarity panelinin içerisinden görüntüleyebilirsiniz.

Her iki servisin en iyi özelliklerini kullanarak hedeflerinize ulaşmaya çalışın. Örneğin bir landing pageiniz var ve buradan sayfayı ziyaret eden misafirlerinizin bir belgeyi indirmesini istiyorsunuz. Hedefinize ait verileri Google Analytics toplarken bunları görselleştiremediğinden dolayı kullanıcıyı caydıran nedenleri tespit etmeniz her zaman kolay olmayacaktır. Microsoft Clarity'nin oturum kaydetme özelliği ile bu hedefi tamamlamayan ziyaretçilerin oturumlarını izleyebilir ve onların bu hedefi tamamlamamalarındaki motivasyonu tespit edebilirsiniz. Bu verilerin entegre olması için herhangi bir özel ayar yapmanıza gerek yok, hepsi otomatik gerçekleşiyor.

## Sonuç olarak
Sitenizde sadece analtik araçları kullanmak değil, üçüncü parti herhangi bir servisi kullanmak kaçınılmaz olarak açılış süresini etkileyecektir. Yukarıda verdiğim örnekteki gibi `async` yükleme bir nebze bu sorunla baş etmenize yardımcı olacaktır. Neyin, ne kadar etki gösterdiğini tespit etmek için tarayıcınızdaki Inspect özelliği ile Network sekmesine gidin ve JavaScript kodlarının boyutları ve yüklenme sürelerini takip edin. Google Tag Manager ile eklemenin yanı sıra Cloudflare veya alternatifi bir CDN servisi kullanıyorsanız analitik kodunuzu doğrudan CDN üzerinden de ekleyebilirsiniz. Ben test etmedim ancak uzmanların bir kısmı olumlu yönde etkisi olduğunu ifade ediyorlar.

Yine de yavaşlık ile ilgili bir sorun yaşıyorsanız bunun temel nedeni analitik servisleri değildir, bu ihtimali biraz daha arka sıralara atmanızda fayda var. Sunucu yanıt süreniz, sayfada kullandığınız elementler, gZip sıkıştırma veya alternatifleri ile sayfa performansını arttırmak önceliğiniz olmalıdır. Yine de analitiklerin yükleme süresine olan etkisine obsesif bir şekilde takıntınız varsa WordPress tabanlı siteleriniz için [Flying Analytics](https://wordpress.org/plugins/flying-analytics/)'i tavsiye ederim. Flying Analtyics, bu belgeleri yerel olarak depolayarak yükleme süresini minimuma indiriyor. 