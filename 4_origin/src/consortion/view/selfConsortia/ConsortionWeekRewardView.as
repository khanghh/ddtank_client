package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaWeekRewardPlayerVo;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionWeekRewardView extends Sprite implements Disposeable
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _list:ListPanel;
      
      private var _lineI:Image;
      
      private var _lineII:Image;
      
      private var _lineIII:Image;
      
      private var _helpText:FilterFrameText;
      
      private var _helpBg:Bitmap;
      
      private var _backBtn:SimpleBitmapButton;
      
      public function ConsortionWeekRewardView()
      {
         super();
         init();
         initList();
      }
      
      private function init() : void
      {
         _titleBg = UICreatShortcut.creatAndAdd("asset.consortion.weekRewardBg",this);
         ObjectUtils.copyPropertyByRectangle(_titleBg,ComponentFactory.Instance.creatCustomObject("consort.week.titleBgRec"));
         _helpBg = UICreatShortcut.creatAndAdd("asset.eventItem.BG",this);
         ObjectUtils.copyPropertyByRectangle(_helpBg,ComponentFactory.Instance.creatCustomObject("consort.week.helpBgRec"));
         var _loc1_:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("flowerGiving.rankView.rankTxt"),this);
         var _loc3_:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.memberList.weekText.text"),this);
         var _loc2_:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.memberList.nameText.text"),this);
         var _loc4_:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.timeBox.awardsInfo"),this);
         _lineI = UICreatShortcut.creatAndAdd("consortion.week.lineI",this);
         _lineII = UICreatShortcut.creatAndAdd("consortion.week.lineII",this);
         _lineIII = UICreatShortcut.creatAndAdd("consortion.week.lineIII",this);
         PositionUtils.setPos(_loc1_,"consort.week.rankPos");
         PositionUtils.setPos(_loc3_,"consort.week.richesPos");
         PositionUtils.setPos(_loc2_,"consort.week.namePos");
         PositionUtils.setPos(_loc4_,"consort.week.rewardPos");
         _list = UICreatShortcut.creatAndAdd("weekMember.list",this);
         _helpText = UICreatShortcut.creatTextAndAdd("consortion.week.help",LanguageMgr.GetTranslation("consortion.week.helpText"),this);
         _backBtn = ComponentFactory.Instance.creat("asset.placardAndEvent.weekRewardView.backBtn");
         addChild(_backBtn);
         _backBtn.addEventListener("click",onClick);
      }
      
      private function initList() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = ConsortionModelManager.Instance.model.richRankList;
         var _loc1_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            if(_loc2_.length > _loc4_ && _loc2_[_loc4_].Rich >= 1000)
            {
               _loc1_.push(_loc2_[_loc4_]);
            }
            else
            {
               _loc3_ = new ConsortiaWeekRewardPlayerVo();
               _loc3_.Rank = _loc4_ + 1;
               _loc3_.Name = "-";
               _loc3_.Rich = 0;
               _loc1_.push(_loc3_);
            }
            _loc4_++;
         }
         _list.vectorListModel.appendAll(_loc1_);
      }
      
      private function compareFunction(param1:ConsortiaPlayerInfo, param2:ConsortiaPlayerInfo) : int
      {
         if(param1.LastWeekRichesOffer > param2.LastWeekRichesOffer)
         {
            return -1;
         }
         if(param1.LastWeekRichesOffer == param2.LastWeekRichesOffer && param1.ID > param2.ID)
         {
            return -1;
         }
         return 1;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortionModelManager.Instance.dispatchEvent(new Event("leave_call_back_view"));
      }
      
      public function dispose() : void
      {
         _backBtn.removeEventListener("click",onClick);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
