package setting.view
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class KeyDefaultSetPanel extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var alphaClickArea:Sprite;
      
      private var _icon:Array;
      
      public var selectedItemID:int = 0;
      
      public function KeyDefaultSetPanel()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("ddtsetting.KeySet.KeyTL");
         var _loc5_:Point = ComponentFactory.Instance.creatCustomObject("ddtsetting.KeySet.KeyRect");
         addEventListener("addedToStage",__addToStage);
         addEventListener("removedFromStage",__removeToStage);
         alphaClickArea = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("ddtsetting.keyset.BGAsset");
         addChild(_bg);
         _icon = [];
         var _loc4_:Array = SharedManager.KEY_SET_ABLE;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(_loc4_[_loc6_]);
            if(_loc3_)
            {
               _loc1_ = new KeySetItem(_loc4_[_loc6_],0,_loc4_[_loc6_],PropItemView.createView(_loc3_.Pic,40,40));
               _loc1_.addEventListener("itemClick",onItemClick);
               _loc1_.x = _loc2_.x + (_loc6_ < 4?_loc6_ * _loc5_.x:Number((_loc6_ - 4) * _loc5_.x));
               _loc1_.y = _loc2_.y + (_loc6_ < 4?0:Number(Math.floor(_loc6_ / 4) * _loc5_.y));
               _loc1_.setClick(true,false,true);
               var _loc7_:int = 40;
               _loc1_.width = _loc7_;
               _loc1_.height = _loc7_;
               _loc1_.setBackgroundVisible(false);
               addChild(_loc1_);
               _icon.push(_loc1_);
            }
            _loc6_++;
         }
      }
      
      private function __addToStage(param1:Event) : void
      {
         alphaClickArea.graphics.beginFill(16711935,0);
         alphaClickArea.graphics.drawRect(-3000,-3000,6000,6000);
         addChildAt(alphaClickArea,0);
         alphaClickArea.addEventListener("click",clickHide);
      }
      
      private function __removeToStage(param1:Event) : void
      {
         alphaClickArea.graphics.clear();
         alphaClickArea.removeEventListener("click",clickHide);
      }
      
      private function clickHide(param1:MouseEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("removedFromStage",__removeToStage);
         while(_icon.length > 0)
         {
            _loc1_ = _icon.shift() as KeySetItem;
            if(_loc1_)
            {
               _loc1_.removeEventListener("itemClick",onItemClick);
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
         _icon = null;
         if(alphaClickArea)
         {
            alphaClickArea.removeEventListener("click",clickHide);
            alphaClickArea.graphics.clear();
            if(alphaClickArea.parent)
            {
               alphaClickArea.parent.removeChild(alphaClickArea);
            }
         }
         alphaClickArea = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function onItemClick(param1:ItemEvent) : void
      {
         SoundManager.instance.play("008");
         selectedItemID = param1.index;
         hide();
         dispatchEvent(new Event("select"));
      }
   }
}
