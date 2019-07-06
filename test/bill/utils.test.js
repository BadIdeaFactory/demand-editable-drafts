import * as chai from "chai";
const expect = chai.expect;

import Utils from "../../src/bill/utils";
describe("Utils", function(){
  it("should know that there are 72 points per inch.", function(){
    expect(Utils.pointsPerInch).to.equal(72);
  });

  it("should know that there are 96 pixels per inch in node.", function(){
    expect(Utils.pixelsPerInch).to.equal(96);
  });

  it("should know that a twip is a twentieth of a point.", function(){
    expect(Utils.twipsPerPoint).to.equal(20);
  });

  it("should be able to convert between pixels, points & twips", function(){
    expect(Utils.pointsToPixels(42)).to.equal(56);
    expect(Utils.pixelsToPoints(56)).to.equal(42);
  });
});