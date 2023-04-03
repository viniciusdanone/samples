import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'section',
  classNames: ['pizza-slice'],
  classNameBindings: ['isShowingPlaces:stop:run'],

  isShowingPlaces: false,

  filteredPlaces: Ember.computed.filter('places', function (place) {
    return place.kiez === this.get('kiez.name');
  }),

  click() {
    return this.toggleProperty('isShowingPlaces');
  }
});
