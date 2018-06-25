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
         var i:int = 0;
         var temp:* = null;
         var icon:* = null;
         var topLeft:Point = ComponentFactory.Instance.creatCustomObject("ddtsetting.KeySet.KeyTL");
         var rect:Point = ComponentFactory.Instance.creatCustomObject("ddtsetting.KeySet.KeyRect");
         addEventListener("addedToStage",__addToStage);
         addEventListener("removedFromStage",__removeToStage);
         alphaClickArea = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("ddtsetting.keyset.BGAsset");
         addChild(_bg);
         _icon = [];
         var sets:Array = SharedManager.KEY_SET_ABLE;
         for(i = 0; i < sets.length; )
         {
            temp = ItemManager.Instance.getTemplateById(sets[i]);
            if(temp)
            {
               icon = new KeySetItem(sets[i],0,sets[i],PropItemView.createView(temp.Pic,40,40));
               icon.addEventListener("itemClick",onItemClick);
               icon.x = topLeft.x + (i < 4?i * rect.x:Number((i - 4) * rect.x));
               icon.y = topLeft.y + (i < 4?0:Number(Math.floor(i / 4) * rect.y));
               icon.setClick(true,false,true);
               var _loc7_:int = 40;
               icon.width = _loc7_;
               icon.height = _loc7_;
               icon.setBackgroundVisible(false);
               addChild(icon);
               _icon.push(icon);
            }
            i++;
         }
      }
      
      private function __addToStage(e:Event) : void
      {
         alphaClickArea.graphics.beginFill(16711935,0);
         alphaClickArea.graphics.drawRect(-3000,-3000,6000,6000);
         addChildAt(alphaClickArea,0);
         alphaClickArea.addEventListener("click",clickHide);
      }
      
      private function __removeToStage(e:Event) : void
      {
         alphaClickArea.graphics.clear();
         alphaClickArea.removeEventListener("click",clickHide);
      }
      
      private function clickHide(e:MouseEvent) : void
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
         var icon:* = null;
         removeEventListener("addedToStage",__addToStage);
         removeEventListener("removedFromStage",__removeToStage);
         while(_icon.length > 0)
         {
            icon = _icon.shift() as KeySetItem;
            if(icon)
            {
               icon.removeEventListener("itemClick",onItemClick);
               icon.dispose();
            }
            icon = null;
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
      
      private function onItemClick(e:ItemEvent) : void
      {
         SoundManager.instance.play("008");
         selectedItemID = e.index;
         hide();
         dispatchEvent(new Event("select"));
      }
   }
}
