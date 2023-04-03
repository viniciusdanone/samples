import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('pizza-place', 'Integration | Component | pizza place', {
  integration: true
});

test('it renders', function(assert) {
  let place = {
    name: 'Foo',
    address: 'An Address'
  };

  this.set('place', place);
  this.render(hbs`{{pizza-place place=place}}`);

  assert.equal(this.$('address').text().trim(), 'An Address');
});
