$(document).ready(function() {
// Prepare random data
// var province_array = [['PL.DS', 1],
//                       ['PL.KP', 2],
//                       ['PL.LB', 3],
//                       ['PL.LD', 4],
//                       ['PL.LU', 5],
//                       ['PL.MA', 6],  "kod_TERYT":"12"
//                       ['PL.MZ', 7], 
//                       ['PL.OP', 8],
//                       ['PL.PD', 9],
//                       ['PL.PK', 10],
//                       ['PL.PM', 11],
//                       ['PL.SK', 12],
//                       ['PL.SL', 13],
//                       ['PL.WN', 14], "kod_TERYT":"28"
//                       ['PL.WP', 15],
//                       ['PL.ZP', 16]]

  $.ajax( { 
    url: "/charts/point_files.json",
    type: "GET",
    dataType:"json",
    success: function(data) {
      paintRegionsCsv(data);
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

function paintRegionsCsv (visualization_data) {
  //$.getJSON('/pl-all.geo.json', function (geojson) {
  $.getJSON('/wojewodztwa.geo.json', function (geojson) {

    // Initiate the chart
    Highcharts.mapChart('regions_csv_div', {
        title: {
            text: 'Obszary inwestycyjne'
        },
        subtitle: {
            text: 'wg zaimportowanych plików CSV'
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
            name: 'Obszary inwestycyjne wg plików CSV o statusie "aktualny"',
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

