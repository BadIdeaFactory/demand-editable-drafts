class BillPage {
  constructor(analyzer){
    this.layout = analyzer;
    this.fonts  = analyzer.styles;
    this.region = analyzer.region;
    this.initializeSections();
  }

  initializeSections(){
    this.main   = {regions: [], text: []};
    this.before = {regions: [], text: []};
    this.after  = {regions: [], text: []};
    return this;
  }

  // this is an example of doing the most basic dump
  // of all of the regions as regions.
  linearizeRegions() {
    let regions = [];
    let linearize = (region) => {
      if (Object.values(region.regions) == 0) {
        return region;
      } else {
        return Object.values(region.regions).map(r => linearize(r));
      }
    };
    return linearize(this.region);
  }
}

export default BillPage;