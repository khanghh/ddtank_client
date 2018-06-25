package treasurePuzzle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TreasurePuzzleHelpContentItem extends Sprite
   {
       
      
      private var bg:Bitmap;
      
      private var titleText:FilterFrameText;
      
      private var contentText:FilterFrameText;
      
      public function TreasurePuzzleHelpContentItem(type:int, title:String, content:String)
      {
         super();
         if(type == 0)
         {
            bg = ComponentFactory.Instance.creat("treasurePuzzle.redTitleBg");
            titleText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.redTitle");
         }
         else if(type == 1)
         {
            bg = ComponentFactory.Instance.creat("treasurePuzzle.blueTitleBg");
            titleText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.blueTitle");
         }
         else if(type == 2)
         {
            bg = ComponentFactory.Instance.creat("treasurePuzzle.yellowTitleBg");
            titleText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.yellowTitle");
         }
         contentText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.helpView.rewardContentText");
         titleText.text = title;
         contentText.text = content;
         addChild(bg);
         addChild(titleText);
         addChild(contentText);
      }
   }
}
