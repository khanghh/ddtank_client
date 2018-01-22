package dayActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import times.updateView.TimesUpdateViewCell;
   
   public class DayActivityAdvView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _updateContentTip:Bitmap;
      
      private var _updateTimeTip:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _updateTimeTxt:FilterFrameText;
      
      public function DayActivityAdvView(param1:Array){super();}
      
      public function dispose() : void{}
   }
}
