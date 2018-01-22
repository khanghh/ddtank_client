package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import kingDivision.KingDivisionManager;
   
   public class ProgressBarView extends Sprite implements Disposeable
   {
       
      
      private var _zoneIndex:int;
      
      private var _dateArr:Array;
      
      private var _zoneImg:ScaleFrameImage;
      
      private var _fristRound:Bitmap;
      
      private var _secondRound:Bitmap;
      
      private var _semifinal:Bitmap;
      
      private var _finals:Bitmap;
      
      private var _proBarAllMovie:MovieClip;
      
      private var _dateAndTimeTxt_Qua:FilterFrameText;
      
      private var _dateAndTimeTxt_FriRou:FilterFrameText;
      
      private var _dateAndTimeTxt_SecRou:FilterFrameText;
      
      private var _dateAndTimeTxt_Sem:FilterFrameText;
      
      private var _dateAndTimeTxt_Fin:FilterFrameText;
      
      private var _index:int;
      
      public function ProgressBarView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _zoneImg = ComponentFactory.Instance.creatComponentByStylename("kingDivision.progressBarView.zoneImg");
         _zoneImg.setFrame(KingDivisionManager.Instance.zoneIndex + 1);
         _fristRound = ComponentFactory.Instance.creatBitmap("asset.progressbar.fristRound");
         _secondRound = ComponentFactory.Instance.creatBitmap("asset.progressbar.secondRound");
         _semifinal = ComponentFactory.Instance.creatBitmap("asset.progressbar.semifinal");
         _finals = ComponentFactory.Instance.creatBitmap("asset.progressbar.finals");
         _proBarAllMovie = ComponentFactory.Instance.creatCustomObject("asset.progressbar.proBarAllMovie");
         addChild(_zoneImg);
         addChild(_fristRound);
         addChild(_secondRound);
         addChild(_semifinal);
         addChild(_finals);
         addChild(_proBarAllMovie);
         addDateAndTime(KingDivisionManager.Instance.dateArr,KingDivisionManager.Instance.model.consortiaMatchStartTime);
      }
      
      public function updateZoneImg(param1:int) : void
      {
         _zoneImg.setFrame(param1 + 1);
         if(param1 == 0)
         {
            updateDateAndTime(KingDivisionManager.Instance.dateArr,KingDivisionManager.Instance.model.consortiaMatchStartTime);
         }
         else if(param1 == 1)
         {
            updateDateAndTime(KingDivisionManager.Instance.allDateArr,KingDivisionManager.Instance.model.consortiaMatchStartTime);
         }
      }
      
      private function addDateAndTime(param1:Array, param2:Array) : void
      {
         _dateAndTimeTxt_Qua = ComponentFactory.Instance.creatComponentByStylename("progressBarView.dateAndTimeTxt0");
         _dateAndTimeTxt_FriRou = ComponentFactory.Instance.creatComponentByStylename("progressBarView.dateAndTimeTxt1");
         _dateAndTimeTxt_SecRou = ComponentFactory.Instance.creatComponentByStylename("progressBarView.dateAndTimeTxt2");
         _dateAndTimeTxt_Sem = ComponentFactory.Instance.creatComponentByStylename("progressBarView.dateAndTimeTxt3");
         _dateAndTimeTxt_Fin = ComponentFactory.Instance.creatComponentByStylename("progressBarView.dateAndTimeTxt4");
         updateDateAndTime(param1,param2);
         addChild(_dateAndTimeTxt_Qua);
         addChild(_dateAndTimeTxt_FriRou);
         addChild(_dateAndTimeTxt_SecRou);
         addChild(_dateAndTimeTxt_Sem);
         addChild(_dateAndTimeTxt_Fin);
      }
      
      private function updateDateAndTime(param1:Array, param2:Array) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         _dateAndTimeTxt_Qua.text = LanguageMgr.GetTranslation("kingDivision.progressBarView.dateAndTimeTxt",param1[0],param2[0],param2[1]);
         _dateAndTimeTxt_FriRou.text = LanguageMgr.GetTranslation("kingDivision.progressBarView.dateAndTimeTxt",param1[1],param2[0],param2[1]);
         _dateAndTimeTxt_SecRou.text = LanguageMgr.GetTranslation("kingDivision.progressBarView.dateAndTimeTxt",param1[2],param2[0],param2[1]);
         _dateAndTimeTxt_Sem.text = LanguageMgr.GetTranslation("kingDivision.progressBarView.dateAndTimeTxt",param1[3],param2[0],param2[1]);
         _dateAndTimeTxt_Fin.text = LanguageMgr.GetTranslation("kingDivision.progressBarView.dateAndTimeTxt",param1[4],param2[0],param2[1]);
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get proBarAllMovie() : MovieClip
      {
         return _proBarAllMovie;
      }
      
      public function set proBarAllMovie(param1:MovieClip) : void
      {
         _proBarAllMovie = param1;
      }
   }
}
