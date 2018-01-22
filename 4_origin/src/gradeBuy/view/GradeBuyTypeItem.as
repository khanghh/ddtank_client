package gradeBuy.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gradeBuy.GradeBuyController;
   import gradeBuy.GradeBuyManager;
   import gradeBuy.ICountDown;
   import shop.view.ShopItemCell;
   
   public class GradeBuyTypeItem extends Sprite implements Disposeable, ICountDown
   {
       
      
      public var data:Object;
      
      private var _itemCell:ShopItemCell;
      
      private var _dateRemainTxt:FilterFrameText;
      
      private var _itemInfo:ItemTemplateInfo;
      
      public function GradeBuyTypeItem(param1:Object)
      {
         super();
         data = param1;
         this.buttonMode = true;
         this.useHandCursor = true;
         _itemInfo = ItemManager.Instance.getTemplateById(param1["id"]);
         var _loc4_:Shape = new Shape();
         _loc4_.graphics.beginFill(0,0);
         _loc4_.graphics.drawRect(0,0,10,10);
         _loc4_.graphics.endFill();
         _itemCell = new ShopItemCell(_loc4_,_itemInfo);
         addChild(_itemCell);
         _dateRemainTxt = ComponentFactory.Instance.creat("gradeBuy.typeItem.timeRemainTxt");
         addChild(_dateRemainTxt);
         var _loc2_:Number = data["date"];
         var _loc3_:Number = _loc2_ - TimeManager.Instance.Now().time;
         if(_loc3_ <= 0)
         {
            _dateRemainTxt.text = "00:00:00";
            GradeBuyManager.getInstance().unRegister(this.name);
         }
         else
         {
            _dateRemainTxt.text = Helpers.getTimeString(_loc3_);
            GradeBuyManager.getInstance().register(this.name,this);
         }
         this.mouseChildren = false;
         this.addEventListener("click",onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         GradeBuyController.getInstance().showItemListView(_itemInfo,data);
      }
      
      public function update() : void
      {
         var _loc1_:Number = data["date"];
         var _loc2_:Number = _loc1_ - TimeManager.Instance.Now().time;
         if(_loc2_ <= 0)
         {
            _dateRemainTxt.text = "00:00:00";
            ObjectUtils.disposeObject(this);
            GradeBuyController.getInstance().arrage();
         }
         else
         {
            _dateRemainTxt.text = Helpers.getTimeString(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         this.removeEventListener("click",onClick);
         GradeBuyManager.getInstance().unRegister(this.name);
         ObjectUtils.disposeAllChildren(this);
         _itemCell = null;
         _dateRemainTxt = null;
      }
   }
}
