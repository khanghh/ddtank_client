package trainer.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class SystemOpenPromptFrame extends Frame
   {
       
      
      private var _iconTxtBg:Bitmap;
      
      private var _btnBg:Bitmap;
      
      private var _tipTxt:FilterFrameText;
      
      private var _btn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _equipCell:BagCell;
      
      private var _toPlace:int;
      
      private var _callback:Function;
      
      private var _type:int;
      
      private var _image:ScaleFrameImage;
      
      public function SystemOpenPromptFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _iconTxtBg = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.iconTxtBg");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("systemOpenPrompt.frame.txt");
         _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.tipTxt");
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.btnBg");
         _btn = ComponentFactory.Instance.creatComponentByStylename("systemOpenPrompt.frame.btn");
         addToContent(_iconTxtBg);
         addToContent(_tipTxt);
         addToContent(_btnBg);
         addToContent(_btn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btn.addEventListener("click",btnClickHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function btnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_type == 9)
         {
            _callback(_equipCell);
         }
         else if(_type == 1)
         {
            SocketManager.Instance.out.syncWeakStep(101);
            SocketManager.Instance.out.syncWeakStep(102);
            _callback(_type);
         }
         else
         {
            _callback(_type);
         }
         dispose();
      }
      
      public function show(type:int, callback:Function, item:InventoryItemInfo = null, toPlace:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3);
         StageResizeUtils.Instance.addAutoResize(this);
         _toPlace = toPlace;
         _type = type;
         _callback = callback;
         switch(int(type) - 1)
         {
            case 0:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.totemIcon");
               break;
            case 1:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.gemstone");
               break;
            case 2:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.getAwardIcon");
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.getAwardTxt");
               break;
            case 3:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.signIcon");
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.signTxt");
               break;
            case 4:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.consortiaBossOpen");
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.consortiaBossOpenTxt");
               _btn.backStyle = "asset.systemOpenPrompt.goBtn";
               break;
            case 5:
               _icon = ComponentFactory.Instance.creatBitmap("asset.battle.iconpic");
               _icon.x = 10;
               _icon.y = 9;
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.battleGroundOpenTxt");
               _btn.backStyle = "asset.systemOpenPrompt.goBtn";
               break;
            case 6:
               _image = ComponentFactory.Instance.creatComponentByStylename("systemOpenPrompt.frame.farmimage");
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.farmCropRipe");
               addToContent(_image);
               break;
            case 7:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.sevenDoubleDungeon");
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.sevenDoubleDungeon");
               _btn.backStyle = "asset.systemOpenPrompt.goBtn";
               break;
            case 8:
               _equipCell = new BagCell(0,item);
               _equipCell.x = 28;
               _equipCell.y = 23;
               _equipCell.setBgVisible(false);
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.getNewEquip");
               _btn.backStyle = "asset.systemOpenPrompt.equipBtn";
               break;
            case 9:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.treasureIcon");
               _icon.x = 10;
               _icon.y = 16;
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.treasure");
               break;
            case 10:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.consortiaGuardIcon");
               _icon.x = 15;
               _icon.y = 13;
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.consortiaGuardOpen");
               _btn.backStyle = "asset.systemOpenPrompt.goBtn";
               break;
            case 11:
               _icon = ComponentFactory.Instance.creatBitmap("asset.systemOpenPrompt.targetIcon");
               _icon.x = 16;
               _icon.y = 16;
               _tipTxt.text = LanguageMgr.GetTranslation("ddt.systemOpenPrompt.targetTxt");
         }
         if(_icon)
         {
            addToContent(_icon);
         }
         if(_equipCell)
         {
            addToContent(_equipCell);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btn)
         {
            _btn.removeEventListener("click",btnClickHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _callback = null;
         ObjectUtils.disposeObject(_iconTxtBg);
         _iconTxtBg = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_btnBg);
         _btnBg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         super.dispose();
      }
   }
}
