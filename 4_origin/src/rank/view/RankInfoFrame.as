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
         var line:* = null;
         var i:int = 0;
         var txt:* = null;
         var j:int = 0;
         var rankAwardInfo:* = null;
         var item:* = null;
         rankTitleNameList = LanguageMgr.GetTranslation("ddt.rankInfoFrame.rankTitle" + String(type)).split("|");
         var posInfo:RankLayouInfo = ComponentFactory.Instance.creatCustomObject("rankInfo.posTitle" + String(type));
         posInfo.TitleTextString = rankTitleNameList;
         var _loc11_:int = 0;
         var _loc10_:* = posInfo.TitleHLinePoint;
         for each(var pt in posInfo.TitleHLinePoint)
         {
            line = ComponentFactory.Instance.creatBitmap("asset.rankInfo.titleLine");
            PositionUtils.setPos(line,pt);
            titleBox.addChild(line);
         }
         for(i = 0; i < posInfo.TitleTextPoint.length; )
         {
            txt = ComponentFactory.Instance.creatComponentByStylename("rankInfo.titleText");
            PositionUtils.setPos(txt,posInfo.TitleTextPoint[i]);
            txt.text = posInfo.TitleTextString[i];
            titleBox.addChild(txt);
            i++;
         }
         var index:int = 1;
         for(j = 0; j < RankManager.instance.reweadDataList.length; )
         {
            rankAwardInfo = RankManager.instance.reweadDataList[j] as RankAwardInfo;
            if(rankAwardInfo.subType == type && rankAwardInfo.rank == index)
            {
               item = new RankInfoItem(type,rankAwardInfo);
               item.x = -18;
               item.y = 43 + 35 * (index - 1);
               itemBox.addChild(item);
               index++;
            }
            j++;
         }
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
    
   
   function RankInfoItem(type:int, info:RankAwardInfo)
   {
      var line:* = null;
      var i:int = 0;
      var txt:* = null;
      var _info1:* = null;
      var _horseNameStrList:* = null;
      var _info:* = null;
      var curLv:int = 0;
      super();
      var posInfo:RankLayouInfo = ComponentFactory.Instance.creatCustomObject("rankInfo.posInfo" + String(type));
      var _loc13_:int = 0;
      var _loc12_:* = posInfo.TitleHLinePoint;
      for each(var pt in posInfo.TitleHLinePoint)
      {
         line = ComponentFactory.Instance.creatBitmap("asset.rankInfo.infoLine");
         PositionUtils.setPos(line,pt);
         addChild(line);
      }
      for(i = 0; i < posInfo.TitleTextPoint.length; )
      {
         txt = ComponentFactory.Instance.creatComponentByStylename("rankInfo.infoText");
         PositionUtils.setPos(txt,posInfo.TitleTextPoint[i]);
         txt.width = posInfo.InfoTextWidth[i];
         switch(int(type) - 1)
         {
            case 0:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     _info1 = new TofflistPlayerInfo();
                     _info1.MountLv = HorseManager.instance.getHorseLevelByExp(parseInt(info.activeValue));
                     _horseNameStrList = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
                     txt.text = _horseNameStrList[_info1.MountsLevel];
                     break;
                  case 2:
                     _info = new TofflistPlayerInfo();
                     _info.MountLv = HorseManager.instance.getHorseLevelByExp(parseInt(info.activeValue));
                     txt.text = _info.MountsLevelInfo;
                     break;
                  case 3:
                     txt.text = info.nickName;
               }
               break;
            case 1:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = ItemManager.Instance.getTemplateById(parseInt(info.activeParam1)).Name;
                     break;
                  case 3:
                     txt.text = info.activeValue;
               }
               break;
            case 2:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = info.itemName;
                     break;
                  case 3:
                     txt.text = info.activeValue;
               }
               break;
            case 3:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = info.activeValue;
               }
               break;
            case 4:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = info.activeValue;
               }
               break;
            case 5:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     curLv = TotemManager.instance.getTotemPointLevel(parseInt(info.activeValue));
                     txt.text = String(TotemManager.instance.getCurrentLv(curLv));
               }
               break;
            case 6:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = info.activeValue;
               }
               break;
            case 7:
               switch(int(i))
               {
                  case 0:
                     txt.text = String(info.rank);
                     break;
                  case 1:
                     txt.text = info.nickName;
                     break;
                  case 2:
                     txt.text = info.activeValue;
               }
         }
         addChild(txt);
         i++;
      }
   }
}
