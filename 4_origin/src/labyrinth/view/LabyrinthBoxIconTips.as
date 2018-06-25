package labyrinth.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import labyrinth.LabyrinthManager;
   
   public class LabyrinthBoxIconTips extends Sprite implements ITip, Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _label:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function LabyrinthBoxIconTips()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = UICreatShortcut.creatAndAdd("ddt.labyrinth.LabyrinthIconTips.BG",this);
         _line = UICreatShortcut.creatAndAdd("ddt.labyrinth.LabyrinthIconTips.line",this);
         _label = UICreatShortcut.creatAndAdd("ddt.labyrinth.LabyrinthIconTips.label",this);
         _content = UICreatShortcut.creatAndAdd("ddt.labyrinth.LabyrinthIconTips.content",this);
         _label.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.label");
         setContentText();
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(data:Object) : void
      {
         if(data)
         {
            _label.text = data["label"];
            _bg.width = 75;
            _bg.height = 40;
            _line.visible = false;
            _content.visible = false;
         }
         else
         {
            _bg.width = 176;
            _bg.height = 66;
            _label.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.label");
            setContentText();
            _line.visible = true;
            _content.visible = true;
         }
      }
      
      private function setContentText() : void
      {
         if(LabyrinthManager.Instance.model.sType == 0)
         {
            _content.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.content0");
         }
         else
         {
            _bg.height = 86;
            _content.text = LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.content1");
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_label);
         _label = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
