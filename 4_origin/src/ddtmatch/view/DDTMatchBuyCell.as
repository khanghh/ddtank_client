package ddtmatch.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DDTMatchBuyCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _zhuTxt:FilterFrameText;
      
      private var _bettingWinTxt:FilterFrameText;
      
      private var _bettingLoseTxt:FilterFrameText;
      
      private var _hostBuy:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var choose:int = 0;
      
      private var _index:int;
      
      private var _type:int;
      
      private var roundNumberMc:MovieClip;
      
      private var winCell:BagCell;
      
      private var loseCell:BagCell;
      
      private var _combox:ComboBox;
      
      private var countryNameList:Array;
      
      private var list:Array;
      
      private var maxBuy:int;
      
      private var _num:int;
      
      public function DDTMatchBuyCell(param1:int, param2:int)
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         countryNameList = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.countryList").split("|");
         list = ServerConfigManager.instance.getDDTKingQuizCityList().split("|");
         super();
         _index = param1;
         _type = param2;
         if(param2 == 0)
         {
            if(param1 % 2 == 0)
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.match.lightbg");
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.match.darkbg");
            }
            maxBuy = int(ServerConfigManager.instance.getDDTKingQuizPersonMaxCount().split("|")[param1]);
         }
         else
         {
            if(param1 % 2 == 0)
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.match.team.lightbg");
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.match.team.darkbg");
            }
            maxBuy = int(ServerConfigManager.instance.getDDTKingQuizTeamMaxCount().split("|")[param1]);
         }
         addChild(_bg);
         roundNumberMc = ClassUtils.CreatInstance("ddtmatch.match.roundNumber");
         addChild(roundNumberMc);
         roundNumberMc.gotoAndStop(param1 + 1);
         PositionUtils.setPos(roundNumberMc,"ddtmatch.match.roundNumberMc.pos");
         _zhuTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.zhutxt");
         addChild(_zhuTxt);
         _zhuTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.zhu");
         _bettingWinTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.bettingWinTxt");
         addChild(_bettingWinTxt);
         _bettingWinTxt.htmlText = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.bettingWin");
         _bettingLoseTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.bettingLoseTxt");
         addChild(_bettingLoseTxt);
         _bettingLoseTxt.htmlText = LanguageMgr.GetTranslation("ddt.DDTMatch.matchView.bettingLose");
         _hostBuy = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.match.buyBtn");
         addChild(_hostBuy);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.countTxt");
         addChild(_countTxt);
         _countTxt.restrict = "0-9";
         _countTxt.maxChars = 4;
         _countTxt.text = "1";
         winCell = new BagCell(1,null,true,null,false);
         winCell.width = 44;
         winCell.height = 44;
         winCell.info = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.getDDTKingQuizWinID());
         addChild(winCell);
         PositionUtils.setPos(winCell,"ddtmatch.match.winCell.pos");
         loseCell = new BagCell(1,null,true,null,false);
         loseCell.width = 44;
         loseCell.height = 44;
         loseCell.info = ItemManager.Instance.getTemplateById(ServerConfigManager.instance.getDDTKingQuizLostID());
         addChild(loseCell);
         PositionUtils.setPos(loseCell,"ddtmatch.match.loseCell.pos");
         _combox = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.match.combox");
         _loc3_ = ComponentFactory.Instance.creatCustomObject("ddtmatch.match.comboxRec");
         ObjectUtils.copyPropertyByRectangle(_combox,_loc3_);
         _combox.beginChanges();
         addChild(_combox);
         _combox.textField.text = "";
         _combox.selctedPropName = "text";
         _loc4_ = 0;
         while(_loc4_ < list.length)
         {
            _combox.listPanel.vectorListModel.append(countryNameList[int(list[_loc4_]) - 1]);
            _loc4_++;
         }
         _combox.commitChanges();
         _num = 1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         _hostBuy.addEventListener("click",clickHandler);
         _countTxt.addEventListener("change",changeHandler);
      }
      
      public function setinfo(param1:int, param2:int) : void
      {
         if(param1 != 0 && param2 != 0)
         {
            _combox.textField.text = countryNameList[int(list[param1 - 1]) - 1];
            _combox.enable = false;
            _countTxt.text = String(param2);
            _countTxt.type = "dynamic";
            _hostBuy.enable = false;
            _hostBuy.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function changeHandler(param1:Event) : void
      {
         var _loc2_:int = _countTxt.text;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         else if(_loc2_ > maxBuy)
         {
            _loc2_ = maxBuy;
         }
         _countTxt.text = _loc2_.toString();
         _num = _loc2_;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _num * ServerConfigManager.instance.getDDTKingQuizPrize())
         {
            LeavePageManager.showFillFrame();
            return;
         }
         var _loc2_:int = countryNameList.indexOf(_combox.textField.text);
         if(_loc2_ != -1)
         {
            SocketManager.Instance.out.buybuybuy(_type + 1,_index + 1,_loc2_ + 1,_num);
         }
      }
      
      private function remove() : void
      {
         _hostBuy.removeEventListener("click",clickHandler);
         _countTxt.removeEventListener("change",changeHandler);
      }
      
      public function dispose() : void
      {
         remove();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_zhuTxt);
         _zhuTxt = null;
         ObjectUtils.disposeObject(_bettingWinTxt);
         _bettingWinTxt = null;
         ObjectUtils.disposeObject(_bettingLoseTxt);
         _bettingLoseTxt = null;
         ObjectUtils.disposeObject(_hostBuy);
         _hostBuy = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(roundNumberMc);
         roundNumberMc = null;
         ObjectUtils.disposeObject(winCell);
         winCell = null;
         ObjectUtils.disposeObject(loseCell);
         loseCell = null;
         ObjectUtils.disposeObject(_combox);
         _combox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
