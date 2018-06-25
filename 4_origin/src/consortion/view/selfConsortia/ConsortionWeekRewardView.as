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
         var rankText:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("flowerGiving.rankView.rankTxt"),this);
         var richesText:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.memberList.weekText.text"),this);
         var nameText:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.memberList.nameText.text"),this);
         var rewardText:FilterFrameText = UICreatShortcut.creatTextAndAdd("consortion.week.titleText",LanguageMgr.GetTranslation("tank.timeBox.awardsInfo"),this);
         _lineI = UICreatShortcut.creatAndAdd("consortion.week.lineI",this);
         _lineII = UICreatShortcut.creatAndAdd("consortion.week.lineII",this);
         _lineIII = UICreatShortcut.creatAndAdd("consortion.week.lineIII",this);
         PositionUtils.setPos(rankText,"consort.week.rankPos");
         PositionUtils.setPos(richesText,"consort.week.richesPos");
         PositionUtils.setPos(nameText,"consort.week.namePos");
         PositionUtils.setPos(rewardText,"consort.week.rewardPos");
         _list = UICreatShortcut.creatAndAdd("weekMember.list",this);
         _helpText = UICreatShortcut.creatTextAndAdd("consortion.week.help",LanguageMgr.GetTranslation("consortion.week.helpText"),this);
         _backBtn = ComponentFactory.Instance.creat("asset.placardAndEvent.weekRewardView.backBtn");
         addChild(_backBtn);
         _backBtn.addEventListener("click",onClick);
      }
      
      private function initList() : void
      {
         var i:int = 0;
         var vo:* = null;
         var list:Array = ConsortionModelManager.Instance.model.richRankList;
         var nullList:Array = [];
         for(i = 0; i < 10; )
         {
            if(list.length > i && list[i].Rich >= 1000)
            {
               nullList.push(list[i]);
            }
            else
            {
               vo = new ConsortiaWeekRewardPlayerVo();
               vo.Rank = i + 1;
               vo.Name = "-";
               vo.Rich = 0;
               nullList.push(vo);
            }
            i++;
         }
         _list.vectorListModel.appendAll(nullList);
      }
      
      private function compareFunction(a:ConsortiaPlayerInfo, b:ConsortiaPlayerInfo) : int
      {
         if(a.LastWeekRichesOffer > b.LastWeekRichesOffer)
         {
            return -1;
         }
         if(a.LastWeekRichesOffer == b.LastWeekRichesOffer && a.ID > b.ID)
         {
            return -1;
         }
         return 1;
      }
      
      private function onClick(evt:MouseEvent) : void
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
