package times.updateView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class TimesUpdateViewCell extends Sprite implements Disposeable
   {
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      public function TimesUpdateViewCell(param1:Object)
      {
         super();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.viewCell.titleTxt");
         _titleTxt.text = "·" + param1.Title;
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.viewCell.contentTxt");
         _contentTxt.text = param1.Text;
         _contentTxt.height = _contentTxt.textHeight + 5;
         addChild(_titleTxt);
         addChild(_contentTxt);
         this.graphics.clear();
         this.graphics.lineStyle(1,5124638);
         this.graphics.moveTo(5,_contentTxt.y + _contentTxt.textHeight + 8);
         this.graphics.lineTo(690,_contentTxt.y + _contentTxt.textHeight + 8);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _titleTxt = null;
         _contentTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
