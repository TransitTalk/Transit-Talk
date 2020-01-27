import {Controller} from "stimulus"
import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import Feature from "ol/Feature";
import OSM from 'ol/source/OSM';
import SourceVector from "ol/source/Vector";
import LayerVector from "ol/layer/Vector";
import { LineString, Point } from "ol/geom";
import { Style, Fill, Stroke } from "ol/style";
import { fromLonLat } from "ol/proj";

export default class extends Controller {
	static targets = ["content"];
	stopId = undefined;
	lineId = undefined;
	lineColor = undefined;
	map = undefined;
	userCoordinates = [0, 0]

	connect() {
		
		this.stopId = this.data.get("stopId");
		this.lineId = this.data.get("lineId");
		this.lineColor = this.data.has("lineColor")
			? "#" + this.data.get("lineColor")
			: "#000";
		console.log(this.data, this.data.get("lineColor"));
		this.load();
	}

	load() {
		
		navigator.geolocation.getCurrentPosition((position) => {
			this.userCoordinates = fromLonLat([position.coords.longitude, position.coords.latitude]);
			this.buildMap();
			fetch("/lines/" + this.lineId + "/get_stops_map")
				.then((response) => response.json())
				.then((stops) => this.addStopOverlay(stops))
		});
	}

	buildMap() {
		console.log('building at', this.userCoordinates);
		this.map = new Map({
			layers: [
				new TileLayer({
				source: new OSM()
				})
			],
			target: 'map',
			view: new View({
				center: this.userCoordinates,
				zoom: 9,
			})
		});
	}

	addStopOverlay(stops) {
		let points = stops.map(stop => [stop.longitude, stop.lattitude]);
		var vectorPoints = new SourceVector({});

		for (var i = 0; i < points.length; i++) {
			points[i] = fromLonLat(points[i]);
			vectorPoints.addFeature(new Feature({
				geometry: new Point(points[i])
			}));
		}
		
		var featureLine = new Feature({
			geometry: new LineString(points)
		});
		
		var vectorLine = new SourceVector({});
		vectorLine.addFeature(featureLine);
		
		var vectorLineLayer = new LayerVector({
			source: vectorLine,
			style: new Style({
				fill: new Fill({ color: this.lineColor, weight: 5 }),
				stroke: new Stroke({ color: this.lineColor, width: 5 })
			})
		});


		var vectorPointlayer = new LayerVector({
			source: vectorPoints
		});


		this.map.addLayer(vectorPointlayer);

		this.map.addLayer(vectorLineLayer);
	}


}
