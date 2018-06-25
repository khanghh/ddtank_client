package bagAndInfo.bag.trailelite
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class TrailEliteView extends Frame
   {
       
      
      private var bg:Bitmap;
      
      private var jinjisai:Bitmap;
      
      private var zhanyi:Bitmap;
      
      private var levelIcon:Bitmap;
      
      private var contributionTxt:FilterFrameText;
      
      private var radioTxt:FilterFrameText;
      
      private var curlevelTxt:FilterFrameText;
      
      private var curLevelValueTxt:FilterFrameText;
      
      private var rateTxt:FilterFrameText;
      
      private var rateValueTxt:FilterFrameText;
      
      private var leftDay:FilterFrameText;
      
      private var leftDayValue:FilterFrameText;
      
      private var confirmBtn:TextButton;
      
      public function TrailEliteView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creat("asset.trailelite.bg" + BagAndInfoManager.Instance.trialEliteModel.battleRank);
         addToContent(bg);
         zhanyi = ComponentFactory.Instance.creat("asset.trailelite.zhanyi");
         zhanyi.x = 66;
         zhanyi.y = 173;
         addToContent(zhanyi);
         jinjisai = ComponentFactory.Instance.creat("asset.trailelite.jinjisai");
         jinjisai.x = 59;
         jinjisai.y = 200;
         addToContent(jinjisai);
         contributionTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.contribution");
         contributionTxt.text = BagAndInfoManager.Instance.trialEliteModel.battleScore + "/500";
         addToContent(contributionTxt);
         radioTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.radio");
         if(BagAndInfoManager.Instance.trialEliteModel.isRankUp)
         {
            radioTxt.text = BagAndInfoManager.Instance.trialEliteModel.rankUpWin + "/" + (BagAndInfoManager.Instance.trialEliteModel.rankUpCount - BagAndInfoManager.Instance.trialEliteModel.rankUpWin);
         }
         else
         {
            radioTxt.text = "--/--";
         }
         addToContent(radioTxt);
         curlevelTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.level");
         curlevelTxt.text = LanguageMgr.GetTranslation("game.trailelite.curlevel") + ":";
         addToContent(curlevelTxt);
         rateTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.rate");
         rateTxt.text = LanguageMgr.GetTranslation("game.trailelite.rate") + ":";
         addToContent(rateTxt);
         leftDay = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.leftDay");
         leftDay.text = LanguageMgr.GetTranslation("game.trailelite.leftDay") + ":";
         addToContent(leftDay);
         leftDayValue = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.leftDayValue");
         leftDayValue.text = LanguageMgr.GetTranslation("game.trailelite.leftDayValue",BagAndInfoManager.Instance.trialEliteModel.lastDays);
         addToContent(leftDayValue);
         curLevelValueTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.levelValue");
         curLevelValueTxt.text = LanguageMgr.GetTranslation("game.trailelite.level" + BagAndInfoManager.Instance.trialEliteModel.battleRank);
         addToContent(curLevelValueTxt);
         rateValueTxt = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.rateValue");
         if(BagAndInfoManager.Instance.trialEliteModel.totalCount)
         {
            rateValueTxt.text = int(BagAndInfoManager.Instance.trialEliteModel.totalWin * 100 / BagAndInfoManager.Instance.trialEliteModel.totalCount) + "%";
         }
         else
         {
            rateValueTxt.text = "0%";
         }
         addToContent(rateValueTxt);
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.TrailEliteView.confirmBtn");
         confirmBtn.text = LanguageMgr.GetTranslation("game.trailelite.confirm");
         addToContent(confirmBtn);
      }
      
      private function addEvent() : void
      {
         confirmBtn.addEventListener("click",_confirmBtnClickHandler);
      }
      
      private function _confirmBtnClickHandler(e:MouseEvent) : void
      {
         onResponse(0);
      }
   }
}
