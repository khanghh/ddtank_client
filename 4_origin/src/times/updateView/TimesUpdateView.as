package times.updateView
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
   
   public class TimesUpdateView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _updateContentTip:Bitmap;
      
      private var _updateTimeTip:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _updateTimeTxt:FilterFrameText;
      
      public function TimesUpdateView(param1:Array, param2:Boolean = false)
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         super();
         if(param2)
         {
            this.graphics.beginFill(8611920);
            this.graphics.drawRect(-5,-46,765,465);
            this.graphics.endFill();
         }
         _bg = ComponentFactory.Instance.creat("asset.timesUpdate.viewBg");
         _updateContentTip = ComponentFactory.Instance.creatBitmap("asset.timesUpdate.updateContentTip");
         _updateTimeTip = ComponentFactory.Instance.creatBitmap("asset.timesUpdate.updateTimeTip");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.contentVBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.contentScrollPanel");
         var _loc3_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new TimesUpdateViewCell(param1[_loc5_]);
            _vbox.addChild(_loc4_);
            _loc5_++;
         }
         _scrollPanel.setView(_vbox);
         _updateTimeTxt = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.updateTimeTxt");
         _updateTimeTxt.text = param1[0].BeginTime.split("T")[0].replace(/-/g,".");
         addChild(_bg);
         addChild(_updateContentTip);
         addChild(_updateTimeTip);
         addChild(_scrollPanel);
         addChild(_updateTimeTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _updateContentTip = null;
         _updateTimeTip = null;
         _scrollPanel = null;
         _updateTimeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
