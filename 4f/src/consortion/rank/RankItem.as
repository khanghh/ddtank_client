package consortion.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RankItem extends Sprite
   {
      
      private static const NO1:int = 1;
      
      private static const NO2:int = 2;
      
      private static const NO3:int = 3;
       
      
      private var _back1:Bitmap;
      
      private var _back2:Bitmap;
      
      private var _data:RankData;
      
      private var _threeTh:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _zoneTxt:FilterFrameText;
      
      private var _light:Bitmap;
      
      public function RankItem(param1:RankData){super();}
      
      protected function initView() : void{}
      
      public function setCampBattleStlye(param1:Boolean) : void{}
      
      private function initRank() : void{}
      
      public function setView(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
