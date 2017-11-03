module ChartsHelper

  def chart_errands_by_status
    pie_chart errands_by_status_charts_path,
      {
        library: {
          title: {text: t('charts.errands_by_status.title')},
          subtitle: {text: t('charts.errands_by_status.subtitle') + " #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_errands_by_month
    line_chart errands_by_month_charts_path, 
      {
        discrete: true,
        library: {
          title: {text: t('charts.errands_by_month.title'), x: -20},
          subtitle: {text: t('charts.errands_by_month.subtitle'), x: -20},
          yAxis: {
            title: {
              text: 'Ilość'
            }
          },
          tooltip: {
            valueSuffix: ' zlecenie (-nia/-eń)'
          },
          plotOptions: {
              series: {
                  showInNavigator: true
              }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_errands_by_month_status
    line_chart errands_by_month_status_charts_path, 
      {
        discrete: true,
        library: {
          title: {text: t('charts.errands_by_month_status.title'), x: -20},
          subtitle: {text: t('charts.errands_by_month_status.subtitle'), x: -20},
          yAxis: {
            title: {
              text: 'Ilość'
            }
          },
          tooltip: {
            valueSuffix: ' zlecenie (-nia/-eń)'
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  # For showed Errand
  def chart_events_by_status_for_errand(id, sub)
    pie_chart events_by_status_for_errand_charts_path(errand_id: id),
      {
        library: {
          title: {text: t('charts.events_by_status_for_xxx.title')},
          subtitle: {text: t('charts.events_by_status_for_xxx.subtitle', data: sub) + ", #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  # For showed User
  def chart_events_by_status_for_user(id, sub)
    pie_chart events_by_status_for_user_charts_path(user_id: id),
      {
        library: {
          title: {text: t('charts.events_by_status_for_xxx.title')},
          subtitle: {text: t('charts.events_by_status_for_xxx.subtitle', data: sub) + ", #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_events_by_status_type_for_user(id, sub)
    bar_chart events_by_status_type_for_user_charts_path(user_id: id), 
      { #adapter: "google",
        discrete: true,
        library: {
          title: {text: t('charts.events_by_status_type.title')},
          subtitle: {text: t('charts.events_by_status_type.subtitle', data: sub)},
          credits: {
            enabled: false
          },
          legend: {
              align: 'right',
              verticalAlign: 'top',
              layout: 'vertical',
              x: 0,
              y: 20
          }
        }
      }
  end

  def chart_events_by_type_status_for_user(id, sub)
    bar_chart events_by_type_status_for_user_charts_path(user_id: id),
      {
        discrete: true,
        library: {
          title: {text: t('charts.events_by_type_status.title')},
          subtitle: {text: t('charts.events_by_type_status.subtitle', data: sub)},
          credits: {
            enabled: false
          },
          legend: {
              align: 'right',
              verticalAlign: 'top',
              layout: 'vertical',
              x: 0,
              y: 20
          }

        }
      }
  end

  def chart_events_by_status
    pie_chart events_by_status_charts_path,
      {
        library: {
          title: {text: t('charts.events_by_status.title')},
          subtitle: {text: t('charts.events_by_status.subtitle') + " #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_events_by_type
    pie_chart events_by_type_charts_path,
      {
        library: {
          title: {text: t('charts.events_by_type.title')},
          subtitle: {text: t('charts.events_by_type.subtitle') + " #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_events_by_type_for_status(status)
    pie_chart events_by_type_for_status_charts_path(status_id: status),
      {
        library: {
          title: {text: t("charts.events_by_type_for_status_#{status}.title")},
          subtitle: {text: t("charts.events_by_type_for_status_#{status}.subtitle") + " #{Time.zone.now.strftime("%Y-%m-%d %H:%M")}"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_events_by_month
    area_chart events_by_month_charts_path, 
      {
        discrete: true,
        library: {
          title: {text: t('charts.events_by_month.title')},
          subtitle: {text: t('charts.events_by_month.subtitle')},
          yAxis: {
            title: {
              text: 'Ilość'
            }
          },
          tooltip: {
            valueSuffix: ' zadanie (-nia/-ań)'
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_events_by_month_type
    line_chart events_by_month_type_charts_path, 
      {
        discrete: true,
        library: {
          title: {text: t('charts.events_by_month_type.title')},
          subtitle: {text: t('charts.events_by_month_type.subtitle')},
          yAxis: {
            title: {
              text: 'Ilość'
            }
          },
          legend: {
              align: 'right',
              verticalAlign: 'bottom',
              layout: 'vertical',
              x: 0,
              y: -20
          },
          tooltip: {
            valueSuffix: ' zadanie (-nia/-ań)'
          },
          credits: {
            enabled: false
          }
        }
      }
  end

end