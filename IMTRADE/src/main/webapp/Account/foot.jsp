<div class="right-sidebar">
    <div class="slimscrollright">
        <div class="rpanel-title"> Parametrage <span><i class="ti-close right-side-toggle"></i></span> </div>
        <div class="r-panel-body">
            <ul id="themecolors" class="m-t-20">
                <li><b>With Light sidebar</b></li>
                <li><a href="javascript:void(0)" data-skin="skin-default" class="default-theme working">1</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-green" class="green-theme">2</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-red" class="red-theme">3</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-blue" class="blue-theme">4</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-purple" class="purple-theme">5</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-megna" class="megna-theme">6</a></li>
                <li class="d-block m-t-30"><b>With Dark sidebar</b></li>
                <li><a href="javascript:void(0)" data-skin="skin-default-dark" class="default-dark-theme ">7</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-green-dark" class="green-dark-theme">8</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-red-dark" class="red-dark-theme">9</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-blue-dark" class="blue-dark-theme">10</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-purple-dark" class="purple-dark-theme">11</a></li>
                <li><a href="javascript:void(0)" data-skin="skin-megna-dark" class="megna-dark-theme ">12</a></li>
            </ul>
            <ul class="m-t-20 chatonline">
                <li><b>Chat option</b></li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/1.jpg" alt="user-img" class="img-circle"> <span>Varun Dhavan <small class="text-success">online</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/2.jpg" alt="user-img" class="img-circle"> <span>Genelia Deshmukh <small class="text-warning">Away</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/3.jpg" alt="user-img" class="img-circle"> <span>Ritesh Deshmukh <small class="text-danger">Busy</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/4.jpg" alt="user-img" class="img-circle"> <span>Arijit Sinh <small class="text-muted">Offline</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/5.jpg" alt="user-img" class="img-circle"> <span>Govinda Star <small class="text-success">online</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/6.jpg" alt="user-img" class="img-circle"> <span>John Abraham<small class="text-success">online</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/7.jpg" alt="user-img" class="img-circle"> <span>Hritik Roshan<small class="text-success">online</small></span></a>
                </li>
                <li>
                    <a href="javascript:void(0)"><img src="../assets/images/users/8.jpg" alt="user-img" class="img-circle"> <span>Pwandeep rajan <small class="text-success">online</small></span></a>
                </li>
            </ul>
        </div>
    </div>
</div>
</div>
</div>

<footer class="footer">
    © 2020 IMTRADE
</footer>

</div>

<script src="../assets/node_modules/jquery/jquery-3.2.1.min.js"></script>
<!-- Bootstrap popper Core JavaScript -->


<!-- Popup message jquery -->
<script src="../assets/node_modules/toast-master/js/jquery.toast.js"></script>
<script src="../assets/node_modules/sticky-kit-master/dist/sticky-kit.min.js"></script>
<script src="../assets/node_modules/sparkline/jquery.sparkline.min.js"></script>

<script>
    // This is for the sticky sidebar    
    $(".stickyside").stick_in_parent({
        offset_top: 100
    });
    $('.stickyside a').click(function () {
        $('html, body').animate({
            scrollTop: $($(this).attr('href')).offset().top - 100
        }, 500);
        return false;
    });
    // This is auto select left sidebar
    // Cache selectors
    // Cache selectors
    var lastId,
            topMenu = $(".stickyside"),
            topMenuHeight = topMenu.outerHeight(),
            // All list items
            menuItems = topMenu.find("a"),
            // Anchors corresponding to menu items
            scrollItems = menuItems.map(function () {
                var item = $($(this).attr("href"));
                if (item.length) {
                    return item;
                }
            });

    // Bind click handler to menu items


    // Bind to scroll
    $(window).scroll(function () {
        // Get container scroll position
        var fromTop = $(this).scrollTop() + topMenuHeight - 250;

        // Get id of current scroll item
        var cur = scrollItems.map(function () {
            if ($(this).offset().top < fromTop)
                return this;
        });
        // Get the id of the current element
        cur = cur[cur.length - 1];
        var id = cur && cur.length ? cur[0].id : "";

        if (lastId !== id) {
            lastId = id;
            // Set/remove active class
            menuItems
                    .removeClass("active")
                    .filter("[href='#" + id + "']").addClass("active");
        }
    });
</script>

<script>

    $(document).ready(function () {
        $("a").click(function () {
            switch ($(this).text()) {
                case "Ouvrir":
                    $('#prive').fadeOut(1000, function () {
                        $(this).remove();
                        $('#body_content').load('DocIMTrade/Open.jsp');
                    });
                    break;
                case "Nouveau":
                    $('#prive').fadeOut(1000, function () {
                        $(this).remove();
                        $('#body_content').load('DocIMTrade/New.jsp');
                    });
                    break;
                case "Archive":
                    $('#prive').fadeOut(1000, function () {
                        $(this).remove();
                        $('#body_content').load('File/index.jsp');
                    });
                    break;
                case "Parametrage":
                    $('#prive').fadeOut(1000, function () {
                        $(this).remove();
                        $('#body_content').load('DocIMTrade/Managment.jsp');
                    });
                    break;
            }
        });
    });


    $(function () {
        "use strict";
        //This is for the Notification top right
        
        // Dashboard 1 Morris-chart
        Morris.Area({
            element: 'morris-area-chart'
            , data: [{
                    period: '2010'
                    , iphone: 50
                    , ipad: 80
                    , itouch: 20
                }, {
                    period: '2011'
                    , iphone: 130
                    , ipad: 100
                    , itouch: 80
                }, {
                    period: '2012'
                    , iphone: 80
                    , ipad: 60
                    , itouch: 70
                }, {
                    period: '2013'
                    , iphone: 70
                    , ipad: 200
                    , itouch: 140
                }, {
                    period: '2014'
                    , iphone: 180
                    , ipad: 150
                    , itouch: 140
                }, {
                    period: '2015'
                    , iphone: 105
                    , ipad: 100
                    , itouch: 80
                }
                , {
                    period: '2016'
                    , iphone: 250
                    , ipad: 150
                    , itouch: 200
                }]
            , xkey: 'period'
            , ykeys: ['iphone', 'ipad', 'itouch']
            , labels: ['iPhone', 'iPad', 'iPod Touch']
            , pointSize: 3
            , fillOpacity: 0
            , pointStrokeColors: ['#00bfc7', '#fb9678', '#9675ce']
            , behaveLikeLine: true
            , gridLineColor: '#e0e0e0'
            , lineWidth: 3
            , hideHover: 'auto'
            , lineColors: ['#00bfc7', '#fb9678', '#9675ce']
            , resize: true
        });
        Morris.Area({
            element: 'morris-area-chart2'
            , data: [{
                    period: '2010'
                    , SiteA: 0
                    , SiteB: 0
                    , }, {
                    period: '2011'
                    , SiteA: 130
                    , SiteB: 100
                    , }, {
                    period: '2012'
                    , SiteA: 80
                    , SiteB: 60
                    , }, {
                    period: '2013'
                    , SiteA: 70
                    , SiteB: 200
                    , }, {
                    period: '2014'
                    , SiteA: 180
                    , SiteB: 150
                    , }, {
                    period: '2015'
                    , SiteA: 105
                    , SiteB: 90
                    , }
                , {
                    period: '2016'
                    , SiteA: 250
                    , SiteB: 150
                    , }]
            , xkey: 'period'
            , ykeys: ['SiteA', 'SiteB']
            , labels: ['Site A', 'Site B']
            , pointSize: 0
            , fillOpacity: 0.4
            , pointStrokeColors: ['#b4becb', '#01c0c8']
            , behaveLikeLine: true
            , gridLineColor: '#e0e0e0'
            , lineWidth: 0
            , smooth: false
            , hideHover: 'auto'
            , lineColors: ['#b4becb', '#01c0c8']
            , resize: true
        });
    });
    // sparkline
    var sparklineLogin = function () {
        $('#sales1').sparkline([20, 40, 30], {
            type: 'pie',
            height: '90',
            resize: true,
            sliceColors: ['#01c0c8', '#7d5ab6', '#ffffff']
        });
        $('#sparkline2dash').sparkline([6, 10, 9, 11, 9, 10, 12], {
            type: 'bar',
            height: '154',
            barWidth: '4',
            resize: true,
            barSpacing: '10',
            barColor: '#25a6f7'
        });

    };
    var sparkResize;

    $(window).resize(function (e) {
        clearTimeout(sparkResize);
        sparkResize = setTimeout(sparklineLogin, 500);
    });
    sparklineLogin();

</script>
<script src="../assets/node_modules/toast-master/js/jquery.toast.js"></script>

</body>

</html>