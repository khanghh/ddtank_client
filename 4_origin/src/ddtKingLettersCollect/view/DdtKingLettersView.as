package ddtKingLettersCollect.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddtKingLettersCollect.DdtKingLettersCollectController;
   import ddtKingLettersCollect.DdtKingLettersCollectManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class DdtKingLettersView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _detailTxt:FilterFrameText;
      
      private var _letterCellList:Vector.<BagCell>;
      
      private var _letterCellComposed:BagCell;
      
      private var _composeBtn:SimpleBitmapButton;
      
      public function DdtKingLettersView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("ast.dkletter.bg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creat("core.roundClosebt");
         PositionUtils.setPos(_closeBtn,"ddtkingletter.close");
         addChild(_closeBtn);
         _timeTxt = ComponentFactory.Instance.creat("ddtkingletter.time");
         _timeTxt.text = "0000.00.00-0000.00.00";
         addChild(_timeTxt);
         _detailTxt = ComponentFactory.Instance.creat("ddtkingletter.detail");
         _detailTxt.text = LanguageMgr.GetTranslation("ddtKingLetter.detail");
         addChild(_detailTxt);
         _letterCellList = new Vector.<BagCell>();
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12518)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12519)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12520)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12521)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12514)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12515)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12516)));
         _letterCellList.push(new BagCell(0,ItemManager.Instance.getTemplateById(12517)));
         var _loc1_:int = _letterCellList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _letterCellList[_loc2_].x = 163 + _loc2_ % 4 * 66;
            _letterCellList[_loc2_].y = 208 + int(_loc2_ / 4) * 55;
            addChild(_letterCellList[_loc2_]);
            _loc2_++;
         }
         _letterCellComposed = new BagCell(0,ItemManager.Instance.getTemplateById(1120370));
         PositionUtils.setPos(_letterCellComposed,"ddtkingletter.cell");
         addChild(_letterCellComposed);
         _composeBtn = ComponentFactory.Instance.creat("ddtkingletter.btn");
         addChild(_composeBtn);
         _composeBtn.addEventListener("click",onComposeClick);
         _closeBtn.addEventListener("click",onCloseBtnClick);
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         DdtKingLettersCollectManager.getInstance().addEventListener("dklc_update",update);
         SocketManager.Instance.addEventListener(PkgEvent.format(288,3),__onExchangeGoods);
         update();
      }
      
      protected function __onExchangeGoods(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         var _loc4_:int = _loc3_.readInt();
         if(_loc2_)
         {
            update();
            SocketManager.Instance.out.getNationDayInfo();
         }
      }
      
      protected function onComposeClick(param1:MouseEvent) : void
      {
         if(_letterCellList.every(canCompose) == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingLetter.notEnough"));
         }
         else
         {
            DdtKingLettersCollectManager.getInstance().sendCompose(0);
         }
      }
      
      private function canCompose(param1:*, param2:int, param3:Vector.<BagCell>) : Boolean
      {
         return int((param1 as BagCell).tbxCount.text) > 0;
      }
      
      public function update(param1:CEvent = null) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Date = DateUtils.getDateByStr(ServerConfigManager.instance.nationalDayDropBeginDate);
         var _loc3_:Date = DateUtils.getDateByStr(ServerConfigManager.instance.nationalDayDropEndDate);
         _timeTxt.text = addZero(_loc2_.fullYear) + "." + addZero(_loc2_.month + 1) + "." + addZero(_loc2_.date);
         _timeTxt.text = _timeTxt.text + ("-" + addZero(_loc3_.fullYear) + "." + addZero(_loc3_.month + 1) + "." + addZero(_loc3_.date));
         var _loc4_:int = _letterCellList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _letterCellList[_loc5_].tbxCount.visible = true;
            _letterCellList[_loc5_].addChild(_letterCellList[_loc5_].tbxCount);
            _letterCellList[_loc5_].tbxCount.text = DdtKingLettersCollectManager.getInstance().WordArray[_loc5_ + 1];
            _loc5_++;
         }
         if(_letterCellList.every(canCompose) == false)
         {
            Helpers.grey(_letterCellComposed);
         }
         else
         {
            Helpers.colorful(_letterCellComposed);
         }
      }
      
      private function addZero(param1:Number) : String
      {
         return Helpers.fixZero(String(param1));
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         if(!(int(param1.keyCode) - 27))
         {
            close();
         }
      }
      
      protected function onCloseBtnClick(param1:MouseEvent) : void
      {
         close();
      }
      
      private function close() : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      public function dispose() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(288,3),__onExchangeGoods);
         SocketManager.Instance.removeEventListener(PkgEvent.format(288,3),__onExchangeGoods);
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         DdtKingLettersCollectManager.getInstance().removeEventListener("dklc_update",update);
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
            _closeBtn.removeEventListener("click",onCloseBtnClick);
         }
         _closeBtn = null;
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_detailTxt != null)
         {
            ObjectUtils.disposeObject(_detailTxt);
         }
         _detailTxt = null;
         if(_timeTxt != null)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_letterCellList != null)
         {
            ObjectUtils.disposeObject(_letterCellList);
         }
         _letterCellList = null;
         if(_letterCellComposed != null)
         {
            ObjectUtils.disposeObject(_letterCellComposed);
         }
         _letterCellComposed = null;
         if(_composeBtn != null)
         {
            _composeBtn.removeEventListener("click",onComposeClick);
            ObjectUtils.disposeObject(_composeBtn);
         }
         _composeBtn = null;
         DdtKingLettersCollectController.getInstance().isShow = false;
      }
   }
}
