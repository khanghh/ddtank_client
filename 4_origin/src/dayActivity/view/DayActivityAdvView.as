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
      
      public function DayActivityAdvView(contentLsit:Array)
      {
         var i:int = 0;
         var tmp:* = null;
         super();
         _bg = ComponentFactory.Instance.creat("asset.timesUpdate.viewBg");
         _bg.width = _bg.width - 15;
         _bg.height = _bg.height + 50;
         _updateContentTip = ComponentFactory.Instance.creatBitmap("asset.timesUpdate.updateContentTip");
         _updateTimeTip = ComponentFactory.Instance.creatBitmap("asset.timesUpdate.updateTimeTip");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.contentVBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.contentScrollPanel");
         _scrollPanel.width = _scrollPanel.width - 15;
         _scrollPanel.height = _scrollPanel.height + 50;
         var tmpLen:int = contentLsit.length;
         for(i = 0; i < tmpLen; )
         {
            tmp = new TimesUpdateViewCell(contentLsit[i]);
            _vbox.addChild(tmp);
            i++;
         }
         _scrollPanel.setView(_vbox);
         _updateTimeTxt = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.view.updateTimeTxt");
         _updateTimeTxt.text = contentLsit[0].BeginTime.split("T")[0].replace(/-/g,".");
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
