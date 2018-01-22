package rank.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import rank.RankManager;
   import rank.data.RankAwardInfo;
   import rank.data.RankLayouInfo;
   
   public class RankInfoFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var rankTitleNameList:Array;
      
      private var type:int;
      
      private var titleBox:Sprite;
      
      private var itemBox:Sprite;
      
      private var _lastRefreshInfo:FilterFrameText;
      
      public function RankInfoFrame()
      {
         super();
         type = RankManager.instance.model.currentInfo.activityChildType;
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rankInfo.bg");
         addToContent(_bg);
         titleBox = new Sprite();
         addToContent(titleBox);
         itemBox = new Sprite();
         addToContent(itemBox);
         addEventListener("response",_responseHandle);
         _lastRefreshInfo = ComponentFactory.Instance.creatComponentByStylename("rankInfo.lastRefreshText");
         addToContent(_lastRefreshInfo);
         _lastRefreshInfo.text = LanguageMgr.GetTranslation("ddt.rankFrame.lastRefresh",RankManager.instance.lastUpdateTime);
      }
      
      private function initData() : void
      {
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         rankTitleNameList = LanguageMgr.GetTranslation("ddt.rankInfoFrame.rankTitle" + String(type)).split("|");
         var _loc2_:RankLayouInfo = ComponentFactory.Instance.creatCustomObject("rankInfo.posTitle" + String(type));
         _loc2_.TitleTextString = rankTitleNameList;
         var _loc11_:int = 0;
         var _loc10_:* = _loc2_.TitleHLinePoint;
         for each(var _loc4_ in _loc2_.TitleHLinePoint)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.rankInfo.titleLine");
            PositionUtils.setPos(_loc5_,_loc4_);
            titleBox.addChild(_loc5_);
         }
         _loc9_ = 0;
         while(_loc9_ < _loc2_.TitleTextPoint.length)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("rankInfo.titleText");
            PositionUtils.setPos(_loc8_,_loc2_.TitleTextPoint[_loc9_]);
            _loc8_.text = _loc2_.TitleTextString[_loc9_];
            titleBox.addChild(_loc8_);
            _loc9_++;
         }
         var _loc1_:int = 1;
         _loc7_ = 0;
         while(_loc7_ < RankManager.instance.reweadDataList.length)
         {
            _loc6_ = RankManager.instance.reweadDataList[_loc7_] as RankAwardInfo;
            if(_loc6_.subType == type && _loc6_.rank == _loc1_)
            {
               _loc3_ = new RankInfoItem(type,_loc6_);
               _loc3_.x = -18;
               _loc3_.y = 43 + 35 * (_loc1_ - 1);
               itemBox.addChild(_loc3_);
               _loc1_++;
            }
            _loc7_++;
         }
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",_responseHandle);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import horse.HorseManager;
import rank.data.RankAwardInfo;
import rank.data.RankLayouInfo;
import tofflist.data.TofflistPlayerInfo;
import totem.TotemManager;

class RankInfoItem extends Sprite
{
    
   
   function RankInfoItem(param1:int, param2:RankAwardInfo)
   {
      var _loc7_:* = null;
      var _loc11_:int = 0;
      var _loc9_:* = null;
      var _loc5_:* = null;
      var _loc3_:* = null;
      var _loc8_:* = null;
      var _loc10_:int = 0;
      super();
      var _loc4_:RankLayouInfo = ComponentFactory.Instance.creatCustomObject("rankInfo.posInfo" + String(param1));
      var _loc13_:int = 0;
      var _loc12_:* = _loc4_.TitleHLinePoint;
      for each(var _loc6_ in _loc4_.TitleHLinePoint)
      {
         _loc7_ = ComponentFactory.Instance.creatBitmap("asset.rankInfo.infoLine");
         PositionUtils.setPos(_loc7_,_loc6_);
         addChild(_loc7_);
      }
      _loc11_ = 0;
      while(_loc11_ < _loc4_.TitleTextPoint.length)
      {
         _loc9_ = ComponentFactory.Instance.creatComponentByStylename("rankInfo.infoText");
         PositionUtils.setPos(_loc9_,_loc4_.TitleTextPoint[_loc11_]);
         _loc9_.width = _loc4_.InfoTextWidth[_loc11_];
         switch(int(param1) - 1)
         {
            case 0:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc5_ = new TofflistPlayerInfo();
                     _loc5_.MountLv = HorseManager.instance.getHorseLevelByExp(parseInt(param2.activeValue));
                     _loc3_ = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
                     _loc9_.text = _loc3_[_loc5_.MountsLevel];
                     break;
                  case 2:
                     _loc8_ = new TofflistPlayerInfo();
                     _loc8_.MountLv = HorseManager.instance.getHorseLevelByExp(parseInt(param2.activeValue));
                     _loc9_.text = _loc8_.MountsLevelInfo;
                     break;
                  case 3:
                     _loc9_.text = param2.nickName;
               }
               break;
            case 1:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = ItemManager.Instance.getTemplateById(parseInt(param2.activeParam1)).Name;
                     break;
                  case 3:
                     _loc9_.text = param2.activeValue;
               }
               break;
            case 2:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = param2.itemName;
                     break;
                  case 3:
                     _loc9_.text = param2.activeValue;
               }
               break;
            case 3:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = param2.activeValue;
               }
               break;
            case 4:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = param2.activeValue;
               }
               break;
            case 5:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc10_ = TotemManager.instance.getTotemPointLevel(parseInt(param2.activeValue));
                     _loc9_.text = String(TotemManager.instance.getCurrentLv(_loc10_));
               }
               break;
            case 6:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = param2.activeValue;
               }
               break;
            case 7:
               switch(int(_loc11_))
               {
                  case 0:
                     _loc9_.text = String(param2.rank);
                     break;
                  case 1:
                     _loc9_.text = param2.nickName;
                     break;
                  case 2:
                     _loc9_.text = param2.activeValue;
               }
         }
         addChild(_loc9_);
         _loc11_++;
      }
   }
}
