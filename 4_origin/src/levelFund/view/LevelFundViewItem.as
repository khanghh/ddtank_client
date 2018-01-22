package levelFund.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import levelFund.LevelFundManager;
   
   public class LevelFundViewItem extends Sprite implements Disposeable
   {
       
      
      private var _itemBg:Bitmap;
      
      private var _itemLine:Bitmap;
      
      private var _moneyIcon:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _buyMultipleTxt:FilterFrameText;
      
      private var _getAwardBtn:TextButton;
      
      private var _info:Object;
      
      private var _index:int;
      
      public function LevelFundViewItem(param1:int = 0)
      {
         _index = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(_index % 2 == 0)
         {
            _itemBg = ComponentFactory.Instance.creatBitmap("levelFund.levelFundViewItem.bg");
            addChild(_itemBg);
         }
         if(_index != 0)
         {
            _itemLine = ComponentFactory.Instance.creatBitmap("levelFund.levelFundViewItem.line");
            addChild(_itemLine);
         }
         _moneyIcon = ComponentFactory.Instance.creatBitmap("asset.ddtshop.PayTypeLabelTicket");
         PositionUtils.setPos(_moneyIcon,"levelFund.levelFundViewItem.moneyPos");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundViewItem.levelTxt");
         _buyMultipleTxt = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundViewItem.buyMultipleTxt");
         _getAwardBtn = ComponentFactory.Instance.creatComponentByStylename("levelFund.levelFundViewItem.getAwardBtn");
         _getAwardBtn.text = LanguageMgr.GetTranslation("levelFund.levelFundViewItem.getAwardBtnTxt");
         addChild(_moneyIcon);
         addChild(_levelTxt);
         addChild(_buyMultipleTxt);
         addChild(_getAwardBtn);
      }
      
      public function updateView(param1:Object, param2:int) : void
      {
         _info = param1;
         _levelTxt.text = LanguageMgr.GetTranslation("levelFund.levelFundViewItem.levelTxt",_info.level);
         if(param2 == 0)
         {
            _buyMultipleTxt.text = param1.money + "";
         }
         else
         {
            _buyMultipleTxt.text = LanguageMgr.GetTranslation("levelFund.levelFundViewItem.buyMultipleTxt",param1.money,param2);
         }
         if(param1.state == 0)
         {
            _getAwardBtn.enable = true;
         }
         else
         {
            _getAwardBtn.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         _getAwardBtn.addEventListener("click",__getAwardBtnClickHandler);
      }
      
      private function __getAwardBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(LevelFundManager.instance.model.buyType == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyLevelMsg"));
            return;
         }
         if(PlayerManager.Instance.Self.Grade < _info.level)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("levelFund.buyLevelFund.buyLevelLimitMsg"));
            return;
         }
         _getAwardBtn.enable = false;
         SocketManager.Instance.out.sendGetLevelFundAward(_info.level);
      }
      
      private function removeEvent() : void
      {
         _getAwardBtn.removeEventListener("click",__getAwardBtnClickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemLine);
         _itemLine = null;
         ObjectUtils.disposeObject(_moneyIcon);
         _moneyIcon = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_buyMultipleTxt);
         _buyMultipleTxt = null;
         ObjectUtils.disposeObject(_getAwardBtn);
         _getAwardBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
