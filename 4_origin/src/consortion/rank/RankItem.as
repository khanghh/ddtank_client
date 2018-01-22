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
      
      public function RankItem(param1:RankData)
      {
         super();
         _data = param1;
         initView();
      }
      
      protected function initView() : void
      {
         _back1 = ComponentFactory.Instance.creat("consortion.item.back1");
         addChild(_back1);
         _back1.visible = false;
         _back2 = ComponentFactory.Instance.creat("consortion.item.back2");
         addChild(_back2);
         _back2.visible = false;
         _threeTh = ComponentFactory.Instance.creat("consortion.rankThreeRink");
         addChild(_threeTh);
         _threeTh.visible = false;
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.rankTxt");
         addChild(_rankTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.nameTxt");
         addChild(_nameTxt);
         _nameTxt.text = _data.Name;
         _zoneTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.scoreTxt");
         _zoneTxt.text = _data.ZoneName;
         _zoneTxt.visible = false;
         _zoneTxt.x = 244;
         _zoneTxt.y = 3;
         addChild(_zoneTxt);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.scoreTxt");
         addChild(_scoreTxt);
         _scoreTxt.text = _data.Score.toString();
         initRank();
      }
      
      public function setCampBattleStlye(param1:Boolean) : void
      {
         _back1.visible = param1;
         _back2.visible = param1;
         _zoneTxt.visible = !param1;
         _zoneTxt.x = 217;
         _nameTxt.autoSize = "center";
         _nameTxt.x = 54;
         _nameTxt.y = 1;
         _scoreTxt.x = 343;
         _scoreTxt.y = 3;
         _threeTh.x = -4;
         _threeTh.y = 0;
         _rankTxt.x = 2;
      }
      
      private function initRank() : void
      {
         if(_data.Rank == 1)
         {
            _threeTh.setFrame(1);
            _threeTh.visible = true;
         }
         else if(_data.Rank == 2)
         {
            _threeTh.setFrame(2);
            _threeTh.visible = true;
         }
         else if(_data.Rank == 3)
         {
            _threeTh.setFrame(3);
            _threeTh.visible = true;
         }
         else
         {
            _rankTxt.text = _data.Rank + "th";
         }
      }
      
      public function setView(param1:int) : void
      {
         if(param1 % 2)
         {
            _back1.visible = true;
         }
         else
         {
            _back2.visible = true;
         }
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
