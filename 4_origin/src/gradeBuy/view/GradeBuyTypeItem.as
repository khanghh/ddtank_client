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
      
      public function GradeBuyTypeItem($data:Object)
      {
         super();
         data = $data;
         this.buttonMode = true;
         this.useHandCursor = true;
         _itemInfo = ItemManager.Instance.getTemplateById($data["id"]);
         var bg:Shape = new Shape();
         bg.graphics.beginFill(0,0);
         bg.graphics.drawRect(0,0,10,10);
         bg.graphics.endFill();
         _itemCell = new ShopItemCell(bg,_itemInfo);
         addChild(_itemCell);
         _dateRemainTxt = ComponentFactory.Instance.creat("gradeBuy.typeItem.timeRemainTxt");
         addChild(_dateRemainTxt);
         var dateStop:Number = data["date"];
         var time:Number = dateStop - TimeManager.Instance.Now().time;
         if(time <= 0)
         {
            _dateRemainTxt.text = "00:00:00";
            GradeBuyManager.getInstance().unRegister(this.name);
         }
         else
         {
            _dateRemainTxt.text = Helpers.getTimeString(time);
            GradeBuyManager.getInstance().register(this.name,this);
         }
         this.mouseChildren = false;
         this.addEventListener("click",onClick);
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         GradeBuyController.getInstance().showItemListView(_itemInfo,data);
      }
      
      public function update() : void
      {
         var dateStop:Number = data["date"];
         var time:Number = dateStop - TimeManager.Instance.Now().time;
         if(time <= 0)
         {
            _dateRemainTxt.text = "00:00:00";
            ObjectUtils.disposeObject(this);
            GradeBuyController.getInstance().arrage();
         }
         else
         {
            _dateRemainTxt.text = Helpers.getTimeString(time);
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
