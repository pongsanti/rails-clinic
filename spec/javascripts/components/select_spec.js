describe("Select", function() {
  var select;
  var id = "customer_prefix";

  beforeEach(function() {
    select = new components.Select({'id': id});
  });

  it("should be able to receive id", function() {
    expect(id).toEqual(select.args['id']);
  });
});