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
      
      public function set Info(param1:HappyMiniGameActiveInfo) : void
      {
         _info = param1;
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
         var _loc3_:String = _info.serverName;
         var _loc4_:int = _loc3_.lastIndexOf(" ");
         if(_loc4_ > 0)
         {
            _loc3_ = _loc3_.substr(_loc4_ + 1,_loc3_.length);
         }
         _regionTxt.text = _loc3_;
         _nameTxt.text = _info.nickName;
         _score.text = _info.score + "";
         _rank.text = _info.rank + "";
         var _loc5_:String = "";
         var _loc2_:String = "";
         if(_info.endtime.hours < 10)
         {
            _loc5_ = "0" + _info.endtime.hours;
         }
         else
         {
            _loc5_ = _info.endtime.hours + "";
         }
         if(_info.endtime.minutes < 10)
         {
            _loc2_ = "0" + _info.endtime.minutes;
         }
         else
         {
            _loc2_ = _info.endtime.minutes + "";
         }
         _days.text = LanguageMgr.GetTranslation("ddt.game.today.dis") + _loc5_ + ":" + _loc2_;
         setIcon(_info.gameType);
      }
      
      private function setIcon(param1:int) : void
      {
         _icon.visible = true;
         if(param1 == 2)
         {
            _icon.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.bombgame.outpos.icon");
         }
         if(param1 == 1)
         {
            _icon.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.bombgame.points.icon");
         }
         if(param1 == 3)
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
         var _loc1_:* = null;
         while(this.numChildren > 0)
         {
            _loc1_ = removeChildAt(0);
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
   }
}
