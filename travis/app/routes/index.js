import Ember from 'ember';

export default Ember.Route.extend({
  ajax: Ember.inject.service(),
  model() {
    return Ember.RSVP.hash({
      kieze: this.get('ajax').request('https://berlin-pizza.herokuapp.com/kieze').then((data) => {
        return data.data;
      }),
      places: this.get('ajax').request('https://berlin-pizza.herokuapp.com/pizza').then((data) => {
        return data.data;
      })
    });
  }
});
