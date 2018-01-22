package totem.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TotemLeftWindowTotemCell extends Sprite implements Disposeable
   {
       
      
      public var level:int;
      
      public var index:int;
      
      public var isCurCanClick:Boolean;
      
      public var isHasLighted:Boolean;
      
      private var _halo:MovieClip;
      
      private var _bgIconSprite:Sprite;
      
      private var _ligthCross:MovieClip;
      
      public function TotemLeftWindowTotemCell(param1:Bitmap, param2:Bitmap)
      {
         super();
         this.mouseEnabled = false;
         _bgIconSprite = new Sprite();
         param2.x = param1.x + 22;
         param2.y = param1.y + 3;
         _bgIconSprite.addChild(param1);
         _bgIconSprite.addChild(param2);
         addChild(_bgIconSprite);
         _halo = ComponentFactory.Instance.creat("asset.totem.totemPointHalo");
         _halo.gotoAndStop(1);
         _halo.x = 46;
         _halo.y = 78;
         _halo.scaleX = 0.8;
         _halo.scaleY = 0.8;
         _halo.mouseChildren = false;
         _halo.mouseEnabled = false;
         _halo.alpha = 0.2;
         _halo.mc.gotoAndStop(1);
         addChildAt(_halo,0);
         _ligthCross = ComponentFactory.Instance.creat("asset.totem.lightCross");
         _ligthCross.gotoAndStop(1);
         _ligthCross.alpha = 0;
         _ligthCross.x = 44;
         _ligthCross.y = 78;
         _ligthCross.mouseChildren = false;
         _ligthCross.mouseEnabled = false;
         _ligthCross.scaleX = 1.6;
         _ligthCross.scaleY = 2;
         addChild(_ligthCross);
      }
      
      public function showLigthCross() : void
      {
         if(_ligthCross)
         {
            TweenLite.to(_ligthCross,0.5,{"alpha":1});
         }
      }
      
      public function hideLigthCross() : void
      {
         if(_ligthCross)
         {
            TweenLite.to(_ligthCross,0.5,{"alpha":0});
         }
      }
      
      public function get bgIconWidth() : Number
      {
         return _bgIconSprite.width;
      }
      
      public function setBgIconSpriteFilter(param1:Array) : void
      {
         _bgIconSprite.filters = param1;
      }
      
      public function dimOutHalo() : void
      {
         if(_halo)
         {
            TweenLite.to(_halo,0.5,{
               "alpha":0.2,
               "scaleX":0.8,
               "scaleY":0.8,
               "onComplete":dimOutHaloCompleteHandler
            });
         }
      }
      
      private function dimOutHaloCompleteHandler() : void
      {
         if(_halo)
         {
            _halo.mc.gotoAndStop(1);
         }
      }
      
      public function brightenHalo() : void
      {
         if(_halo)
         {
            TweenLite.to(_halo,0.5,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "onComplete":brightenHaloCompleteHandler
            });
         }
      }
      
      private function brightenHaloCompleteHandler() : void
      {
         if(_halo)
         {
            _halo.mc.gotoAndPlay(1);
         }
      }
      
      public function dispose() : void
      {
         if(_halo)
         {
            _halo.gotoAndStop(2);
            if(_halo.parent)
            {
               _halo.parent.removeChild(_halo);
            }
            _halo = null;
         }
         if(_ligthCross)
         {
            _ligthCross.gotoAndStop(2);
            if(_ligthCross.parent)
            {
               _ligthCross.parent.removeChild(_ligthCross);
            }
            _ligthCross = null;
         }
      }
   }
}
