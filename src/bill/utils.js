const twipsPerPoint = 20;
const pointsPerInch = 72; // fontSize is measured in pixels w/ a a 72dpi assumption
const pixelsPerInch = (96*window.devicePixelRatio);
const twipsPerInch  = pointsPerInch * twipsPerPoint;

const Utils = {
  twipsPerPoint: twipsPerPoint,
  twipsPerInch:  twipsPerInch,
  pointsPerInch: pointsPerInch,
  defaultMargin: 1*pixelsPerInch, // 1 inch

  pixelsToPoints: (px) => { return px * (pointsPerInch/pixelsPerInch); },
  pixelsToTWIPs:  (px) => { return Utils.pixelsToPoints(px) * twipsPerPoint; },
  pointsToPixels: (points) => { return points * (pixelsPerInch / pointsPerInch); },
  twipsToPixels:  (twips) => { return Utils.pointsToPixels * twipsPerPoint; },
  closeEnough: (a, b, delta=0.001) => { return (Math.abs(a - b) < delta); },
};

export default Utils;