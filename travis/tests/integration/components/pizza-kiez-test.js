import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('pizza-kiez', 'Integration | Component | pizza kiez', {
  integration: true
});

test('it renders', function (assert) {

  let kiez = {
    name: 'Foo',
    long: 'Foobar'
  };

  this.set('kiez', kiez);

  this.render(hbs`{{pizza-kiez kiez=kiez}}`);

  assert.equal(this.$('.slice-header small').text().trim(), 'Foobar');
});
