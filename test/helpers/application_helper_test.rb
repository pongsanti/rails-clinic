class ApplicationHelperTest < ActionView::TestCase

  class Customer 
    attr_accessor :birthdate
  end

  setup do
    I18n.locale = :en
    @customer = Customer.new
    @customer.birthdate = Date.today - 1.year
  end

  test "should display buddhist era" do
    assert_dom_equal %{<select id="customer_birthdate_1i" name="customer[birthdate(1i)]">
<option value="2011">2011 (2554)</option>
<option value="2012">2012 (2555)</option>
<option value="2013">2013 (2556)</option>
<option value="2014">2014 (2557)</option>
<option value="2015" selected="selected">2015 (2558)</option>
<option value="2016">2016 (2559)</option>
</select>
<select id="customer_birthdate_2i" name="customer[birthdate(2i)]">
<option value="1">January</option>
<option value="2">February</option>
<option value="3">March</option>
<option value="4">April</option>
<option value="5">May</option>
<option value="6">June</option>
<option value="7">July</option>
<option value="8">August</option>
<option value="9">September</option>
<option value="10">October</option>
<option value="11" selected="selected">November</option>
<option value="12">December</option>
</select>
<select id="customer_birthdate_3i" name="customer[birthdate(3i)]">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10" selected="selected">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
<option value="26">26</option>
<option value="27">27</option>
<option value="28">28</option>
<option value="29">29</option>
<option value="30">30</option>
<option value="31">31</option>
</select>
},
    (date_select "customer", "birthdate", {start_year: Date.today.year - 5, end_year: Date.today.year, buddhist_era: true})
  end

end