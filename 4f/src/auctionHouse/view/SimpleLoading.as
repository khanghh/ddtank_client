package auctionHouse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class SimpleLoading extends Sprite implements Disposeable   {            public static var _instance:SimpleLoading;                   private var _view:Sprite;            public function SimpleLoading() { super(); }
            public static function get instance() : SimpleLoading { return null; }
            public function show() : void { }
            public function hide() : void { }
            public function dispose() : void { }
   }}