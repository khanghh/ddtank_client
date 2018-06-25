package guildMemberWeek.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AddRankingRecordItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _countTxt:FilterFrameText;
      
      public function AddRankingRecordItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.guildmemberweek.MainrightRecordBG.png");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.Right.AddRankingRecordItem.countTxt");
         addChild(_bg);
         addChild(_countTxt);
      }
      
      public function initText(ShowText:String) : void
      {
         _countTxt.text = ShowText;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
