package redEnvelope.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import redEnvelope.RedEnvelopeManager;
   import redEnvelope.event.RedEnvelopeEvent;
   
   public class RedEnvelopeInfoItem extends Sprite
   {
       
      
      private var _redInfoTxt:FilterFrameText;
      
      public var getBtn:BaseButton;
      
      private var redCell:BagCell;
      
      private var _itemSelected:Bitmap;
      
      private var _bg:Bitmap;
      
      public var _id:int;
      
      private var _clickTime:Number = 0;
      
      public function RedEnvelopeInfoItem(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true)
      {
         super();
         _id = param4;
         _bg = ComponentFactory.Instance.creatBitmap("asset.redEnvelope.item.bg" + String(param1 % 2));
         addChild(_bg);
         _itemSelected = ComponentFactory.Instance.creatBitmap("asset.redEnvelope.itemSelected");
         addChild(_itemSelected);
         _itemSelected.visible = false;
         _redInfoTxt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.redInfoTxt");
         addChild(_redInfoTxt);
         _redInfoTxt.text = "[" + param3 + "]" + LanguageMgr.GetTranslation("ddt.redEnvelope.sendInfo");
         getBtn = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.getBtn");
         addChild(getBtn);
         getBtn.enable = param5;
         if(param5)
         {
            getBtn.addEventListener("click",clickHandler);
         }
         _redInfoTxt.textFormatStyle = "redEnvelope.redInfoTxtTF_" + String(param2);
         redCell = new BagCell(0);
         redCell.BGVisible = false;
         redCell.setContentSize(34,34);
         redCell.info = ItemManager.Instance.getTemplateById(RedEnvelopeItem.redList[param2 - 1]);
         addChild(redCell);
         redCell.x = _redInfoTxt.x + _redInfoTxt.textWidth + 5;
         redCell.y = 9;
         this.addEventListener("click",thisClickHandler);
      }
      
      private function thisClickHandler(param1:MouseEvent) : void
      {
         if(RedEnvelopeManager.instance.checkCanClick)
         {
            RedEnvelopeManager.instance.checkCanClick = false;
            SoundManager.instance.play("008");
            _itemSelected.visible = true;
            dispatchEvent(new RedEnvelopeEvent("choose",_id));
         }
      }
      
      public function btnDarkSet() : void
      {
         getBtn.enable = false;
      }
      
      public function unSelectSet() : void
      {
         _itemSelected.visible = false;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade < 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.redEnvelope.levelLess"));
            return;
         }
         if(RedEnvelopeManager.instance.checkCanClick)
         {
            SocketManager.Instance.out.getRedEnvelope(_id);
            getBtn.enable = false;
            getBtn.removeEventListener("click",clickHandler);
         }
      }
      
      public function dispose() : void
      {
         if(_redInfoTxt)
         {
            ObjectUtils.disposeObject(_redInfoTxt);
         }
         _redInfoTxt = null;
         if(getBtn.hasEventListener("click"))
         {
            getBtn.removeEventListener("click",clickHandler);
         }
         if(getBtn)
         {
            ObjectUtils.disposeObject(getBtn);
         }
         getBtn = null;
         if(redCell)
         {
            ObjectUtils.disposeObject(redCell);
         }
         redCell = null;
         if(_itemSelected)
         {
            ObjectUtils.disposeObject(_itemSelected);
         }
         _itemSelected = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
      }
   }
}
