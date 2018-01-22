package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TaskPannelStripView extends Sprite
   {
      
      private static const THIS_HEIGHT:int = 37;
      
      private static const THIS_WIDTH:int = 214;
       
      
      private var _bg:ScaleFrameImage;
      
      private var _info:QuestInfo;
      
      private var _status:String;
      
      private var titleField:FilterFrameText;
      
      private var bmpNEW:MovieClip;
      
      private var bmpOK:Bitmap;
      
      private var bmpRecommond:Bitmap;
      
      private var _light:Scale9CornerImage;
      
      private var _trusteeshipTxtImg:Bitmap;
      
      private var _style:int = 1;
      
      public function TaskPannelStripView(param1:QuestInfo)
      {
         super();
         _info = param1;
         initView();
         addEvent();
      }
      
      public function set status(param1:String) : void
      {
         if(param1 == _status)
         {
            return;
         }
         _status = param1;
         update();
      }
      
      private function get isHovered() : Boolean
      {
         return _status == "hover";
      }
      
      private function get isSelected() : Boolean
      {
         return _status == "active";
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("core.quest.MCQuestItemBG");
         _bg.setFrame(1);
         addChild(_bg);
         _light = ComponentFactory.Instance.creatComponentByStylename("asset.core.quest.QuestItemLight");
         addChild(_light);
         _light.visible = false;
         titleField = ComponentFactory.Instance.creat("core.quest.QuestItemTitleNormal");
         addChild(titleField);
         mouseChildren = false;
         buttonMode = true;
         bmpNEW = ClassUtils.CreatInstance("asset.quest.newMovie") as MovieClip;
         bmpNEW.visible = false;
         addChild(bmpNEW);
         PositionUtils.setPos(bmpNEW,"quest.bmpNEWPosForStrip");
         _trusteeshipTxtImg = ComponentFactory.Instance.creat("asset.trusteeship.textImg");
         _trusteeshipTxtImg.visible = false;
         addChild(_trusteeshipTxtImg);
         bmpOK = ComponentFactory.Instance.creat("asset.core.quest.textImg.OK");
         bmpOK.visible = false;
         addChild(bmpOK);
         bmpRecommond = ComponentFactory.Instance.creatBitmap("asset.core.quest.recommend");
         bmpRecommond.rotation = 15;
         bmpRecommond.smoothing = true;
         bmpRecommond.visible = false;
         addChild(bmpRecommond);
         titleField.text = _info.Title;
         status = "normal";
         update();
      }
      
      public function set taskStyle(param1:int) : void
      {
         _style = param1;
      }
      
      public function get info() : QuestInfo
      {
         return _info;
      }
      
      protected function addEvent() : void
      {
         addEventListener("mouseOver",__onRollOver);
         addEventListener("mouseOut",__onRollOut);
         addEventListener("click",__onClick);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("mouseOver",__onRollOver);
         removeEventListener("mouseOut",__onRollOut);
         removeEventListener("click",__onClick);
      }
      
      public function update() : void
      {
         if(_info.isCompleted)
         {
            bmpOK.visible = true;
            _trusteeshipTxtImg.visible = false;
         }
         else
         {
            bmpOK.visible = false;
            if(TrusteeshipManager.instance.getTrusteeshipInfo(_info.id))
            {
               _trusteeshipTxtImg.visible = true;
            }
            else
            {
               _trusteeshipTxtImg.visible = false;
            }
            if(_info.StarLev == 1)
            {
               bmpRecommond.visible = true;
            }
            else
            {
               bmpRecommond.visible = false;
               if(_info.data && _info.data.isNew)
               {
                  if(bmpNEW.visible == false)
                  {
                     bmpNEW.visible = true;
                     bmpNEW.gotoAndPlay(1);
                  }
               }
               else
               {
                  bmpNEW.visible = false;
               }
            }
         }
         if(_info.data && _info.data.quality > 1)
         {
            titleField.setFrame(3);
         }
         else
         {
            titleField.setFrame(1);
         }
         if(isSelected)
         {
            _bg.setFrame(2);
            if(_info.data && _info.data.quality > 1)
            {
               titleField.setFrame(4);
            }
            else
            {
               titleField.setFrame(2);
            }
            _light.visible = false;
         }
         else if(isHovered)
         {
            _light.visible = true;
         }
         else
         {
            _bg.setFrame(1);
            _light.visible = false;
         }
      }
      
      private function __onRollOver(param1:MouseEvent) : void
      {
         if(isSelected)
         {
            return;
         }
         status = "hover";
      }
      
      private function __onRollOut(param1:MouseEvent) : void
      {
         if(isSelected)
         {
            return;
         }
         status = "normal";
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TaskControl.instance.MainFrame.currentNewCateView = null;
         if(_info.data)
         {
            _info.data.isNew = false;
         }
         _active();
      }
      
      protected function _active() : void
      {
         TaskManager.instance.jumpToQuest(_info);
         if(isSelected)
         {
            return;
         }
         dispatchEvent(new TaskEvent("changed",_info,_info.data));
         status = "active";
         _light.visible = true;
      }
      
      protected function _deactive() : void
      {
         if(isSelected)
         {
            status = "normal";
            _light.visible = false;
         }
      }
      
      public function onShow() : void
      {
         bmpNEW.gotoAndPlay(1);
      }
      
      public function active() : void
      {
         _active();
      }
      
      public function deactive() : void
      {
         _deactive();
      }
      
      override public function get width() : Number
      {
         return 214;
      }
      
      override public function get height() : Number
      {
         return 37;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _info = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(titleField)
         {
            ObjectUtils.disposeObject(titleField);
         }
         titleField = null;
         if(bmpNEW)
         {
            ObjectUtils.disposeObject(bmpNEW);
         }
         bmpNEW = null;
         if(bmpOK)
         {
            ObjectUtils.disposeObject(bmpOK);
         }
         bmpOK = null;
         if(_trusteeshipTxtImg)
         {
            ObjectUtils.disposeObject(_trusteeshipTxtImg);
         }
         _trusteeshipTxtImg = null;
         if(bmpRecommond)
         {
            ObjectUtils.disposeObject(bmpRecommond);
         }
         bmpRecommond = null;
         if(_light)
         {
            ObjectUtils.disposeObject(_light);
         }
         _light = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
