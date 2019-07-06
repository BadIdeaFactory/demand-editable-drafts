const runningInNode = (typeof module !== 'undefined' && typeof module.exports !== 'undefined');
const pixelRatio = (runningInNode) ? 1 : window.devicePixelRatio;
const pixelsPerInch = (96*pixelRatio);
const pointsPerInch = 72; // fontSize is measured in pixels w/ a a 72dpi assumption
const twipsPerPoint = 20;
const twipsPerInch  = pointsPerInch * twipsPerPoint;

const Utils = {
  twipsPerPoint: twipsPerPoint,
  twipsPerInch:  twipsPerInch,
  pointsPerInch: pointsPerInch,
  pixelsPerInch: pixelsPerInch,
  defaultMargin: 1*pixelsPerInch, // 1 inch

  pixelsToPoints: (px) => { return px * (pointsPerInch/pixelsPerInch); },
  pixelsToTwips:  (px) => { return Utils.pixelsToPoints(px) * twipsPerPoint; },
  pointsToPixels: (points) => { return points * (pixelsPerInch / pointsPerInch); },
  twipsToPixels:  (twips) => { return Utils.pointsToPixels(twips / twipsPerPoint); },
  closeEnough: (a, b, delta=0.001) => { return (Math.abs(a - b) < delta); },
};

export default Utils;