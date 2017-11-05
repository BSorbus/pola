$(document).ready(function() {
// Prepare random data
// var province_array = [['PL.DS', 1],
//                       ['PL.KP', 2],
//                       ['PL.LB', 3],
//                       ['PL.LD', 4],
//                       ['PL.LU', 5],
//                       ['PL.MA', 6],
//                       ['PL.MZ', 7],
//                       ['PL.OP', 8],
//                       ['PL.PD', 9],
//                       ['PL.PK', 10],
//                       ['PL.PM', 11],
//                       ['PL.SK', 12],
//                       ['PL.SL', 13],
//                       ['PL.WN', 14],
//                       ['PL.WP', 15],
//                       ['PL.ZP', 16]]

  $.ajax( { 
    url: "/charts/xml_partner_tables.json",
    type: "GET",
    dataType:"json",
    success: function(data) {
      paintRegionsXml(data);
      //console.log('Do whatever you want with ' + data + '.');
    },
    error: function (jqXHR, exception) {
      console.log(jqXHR);
      if (jqXHR.status == 401) {
        window.location.reload();
      } else {
        getErrorMessage(jqXHR, exception);
      }
    }
  });

});

function paintRegionsXml (visualization_data) {
  $.getJSON('/pl-all.geo.json', function (geojson) {

    // Initiate the chart
    Highcharts.mapChart('regions_xml_div', {
        title: {
            text: 'Projekty'
        },
        subtitle: {
            text: 'wg zaimportowanych plików XML'
        },
        mapNavigation: {
            enabled: true,
            buttonOptions: {
                verticalAlign: 'bottom'
            }
        },
        colorAxis: {
            tickPixelInterval: 100
        },

        tooltip: {
            formatter: function () {
                return '' + this.series.name + '<br>' +
                    'Obszar: <b>' + this.point.properties.type + '</b><br>' +
                    'Nazwa: <b>' + this.point.properties["alt-name"] + '</b><br>' +
                    'Ilość: <b>' + this.point.value + '</b>';
            }
        },

        series: [{
            data: visualization_data,
            mapData: geojson,
            joinBy: ['hasc', 0],
            keys: ['hasc', 'value'],
            name: 'Projekty wg plików XML o statusie "aktualny"',
            states: {
                hover: {
                    color: '#BECC25'
                }
            },
            dataLabels: {
                enabled: true,
                //format: '{point.properties.alt-name}'
                format: '{point.properties.postal-code} ({point.value})'
            }
        }]
    });

  });
};

