package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import uiModeManager.bombUI.model.HappyMiniGameActiveInfo;
   
   public class HappyMiniDayNewItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _regionTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _titleScore:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _titleRank:FilterFrameText;
      
      private var _rank:FilterFrameText;
      
      private var _days:FilterFrameText;
      
      private var _info:HappyMiniGameActiveInfo;
      
      public function HappyMiniDayNewItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.cubeGame.princessIcon");
         _regionTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemTxt");
         _titleScore = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemTxt");
         _titleRank = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemTxt");
         _score = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemScoreTxt");
         _rank = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemScoreTxt");
         _days = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.itemScoreTxt");
         _regionTxt.text = "";
         _nameTxt.text = "";
         _score.text = "";
         _titleRank.text = LanguageMgr.GetTranslation("happyLittleGame.DayRank");
         _rank.text = "";
         _days.text = "";
         PositionUtils.setPos(_nameTxt,"bombgame.daynewsview.pointII");
         PositionUtils.setPos(_titleScore,"bombgame.daynewsview.pointIII");
         PositionUtils.setPos(_titleRank,"bombgame.daynewsview.pointIIII");
         PositionUtils.setPos(_score,"bombgame.daynewsview.score");
         PositionUtils.setPos(_rank,"bombgame.daynewsview.scoreII");
         PositionUtils.setPos(_days,"bombgame.daynewsview.scoreIII");
         addChild(_icon);
         addChild(_regionTxt);
         addChild(_nameTxt);
         addChild(_titleScore);
         addChild(_titleRank);
         addChild(_score);
         addChild(_rank);
         addChild(_days);
      }
      
      public function set Info(info:HappyMiniGameActiveInfo) : void
      {
         _info = info;
         if(_info == null)
         {
            return;
         }
         _titleScore.text = LanguageMgr.GetTranslation("happyLittleGame.DayNew.GetScore");
         if(_info.rankType == 2)
         {
            _titleRank.text = LanguageMgr.GetTranslation("happyLittleGame.DayRank");
         }
         if(_info.rankType == 1)
         {
            _titleRank.text = LanguageMgr.GetTranslation("happyLittleGame.TotalRank");
         }
         var region:String = _info.serverName;
         var index:int = region.lastIndexOf(" ");
         if(index > 0)
         {
            region = region.substr(index + 1,region.length);
         }
         _regionTxt.text = region;
         _nameTxt.text = _info.nickName;
         _score.text = _info.score + "";
         _rank.text = _info.rank + "";
         var hour:String = "";
         var min:String = "";
         if(_info.endtime.hours < 10)
         {
            hour = "0" + _info.endtime.hours;
         }
         else
         {
            hour = _info.endtime.hours + "";
         }
         if(_info.endtime.minutes < 10)
         {
            min = "0" + _info.endtime.minutes;
         }
         else
         {
            min = _info.endtime.minutes + "";
         }
         _days.text = LanguageMgr.GetTranslation("ddt.game.today.dis") + hour + ":" + min;
         setIcon(_info.gameType);
      }
      
      private function setIcon(gameType:int) : void
      {
         _icon.visible = true;
         if(gameType == 2)
         {
            _icon.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.bombgame.outpos.icon");
         }
         if(gameType == 1)
         {
            _icon.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.bombgame.points.icon");
         }
         if(gameType == 3)
         {
            _icon.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.cubeGame.princessIcon");
         }
      }
      
      public function get Info() : HappyMiniGameActiveInfo
      {
         return _info;
      }
      
      public function clear() : void
      {
         if(_icon)
         {
            _icon.visible = false;
         }
         if(_regionTxt)
         {
            _regionTxt.text = "";
         }
         if(_nameTxt)
         {
            _nameTxt.text = "";
         }
         if(_score)
         {
            _score.text = "";
         }
         if(_rank)
         {
            _rank.text = "";
         }
         if(_days)
         {
            _days.text = "";
         }
         if(_titleScore)
         {
            _titleScore.text = "";
         }
         if(_titleRank)
         {
            _titleRank.text = "";
         }
      }
      
      public function dispose() : void
      {
         var obj:* = null;
         while(this.numChildren > 0)
         {
            obj = removeChildAt(0);
            if(obj)
            {
               ObjectUtils.disposeObject(obj);
               obj = null;
            }
         }
      }
   }
}
