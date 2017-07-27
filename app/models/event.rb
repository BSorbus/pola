class Event < ApplicationRecord

  EVENT_COLORS = [['black',   'black',    {:style => "background-color: black;    color: white"}], 
                  ['blue',    'blue',     {:style => "background-color: blue;     color: white"}],
                  ['gray',    'gray',     {:style => "background-color: gray;     color: white"}],
                  ['green',   'green',    {:style => "background-color: green;    color: white"}], 
                  ['fuchsia', 'fuchsia',  {:style => "background-color: fuchsia;  color: white"}],
                  ['orange',  'orange',   {:style => "background-color: orange;   color: white"}],
                  ['red',     'red',      {:style => "background-color: red;      color: white"}]]


  # validates
  validates :title, presence: true,
                    length: { in: 1..100 }

  validates :start_date, presence: true

  def fullname
    "#{self.title}"
  end

end
