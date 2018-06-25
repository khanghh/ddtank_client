package prayIndiana{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import flash.events.Event;   import prayIndiana.view.PrayIndianaFrame;      public class PrayIndianaController   {            private static var _instance:PrayIndianaController;                   private var _pray:PrayIndianaFrame;            public function PrayIndianaController(pct:PrivateClass) { super(); }
            public static function get Instance() : PrayIndianaController { return null; }
            public function setup() : void { }
            private function __onPrayIndianaDispose(evt:Event) : void { }
            private function __onUpdateLottery(evt:Event) : void { }
            private function __onUpdateLotteryNumber(evt:Event) : void { }
            private function __onPrayIndianaOpenFrame(evt:Event) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}