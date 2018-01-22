package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.EnthrallManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class ExpTotalItem extends Sprite implements Disposeable
   {
       
      
      public var value:Number;
      
      private var _expTxt:Bitmap;
      
      private var _exploitTxt:Bitmap;
      
      private var _expNumTxt:ExpTotalNums;
      
      private var _exploitNumTxt:ExpTotalNums;
      
      private var _bg:Bitmap;
      
      private var _bitmap:Bitmap;
      
      private var _speed:Number;
      
      private var _enthrallBit:Bitmap;
      
      public function ExpTotalItem()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _speed = 0.05;
         _bg = ComponentFactory.Instance.creatBitmap("asset.experience.rightViewTotalBg");
         _bitmap = ComponentFactory.Instance.creatBitmap("asset.experience.rightViewTotalTxt");
         _enthrallBit = ComponentFactory.Instance.creatBitmap("asset.core.EnthrallIcon");
         _expTxt = ComponentFactory.Instance.creatBitmap("asset.experience.TotalExpTxt");
         if(GameControl.Instance.Current.roomType != 0 && GameControl.Instance.Current.roomType != 1 && GameControl.Instance.Current.roomType != 16 && GameControl.Instance.Current.roomType != 120)
         {
            _expTxt.y = _expTxt.y + 17;
         }
         else if(GameControl.Instance.Current.roomType == 120)
         {
            _exploitTxt = ComponentFactory.Instance.creatBitmap("asset.experience.TotalPrestigeTxt");
         }
         else
         {
            _exploitTxt = ComponentFactory.Instance.creatBitmap("asset.experience.TotalExploitTxt");
         }
         PositionUtils.setPos(this,"experience.RightViewTotalPos");
         addChild(_bg);
         addChild(_bitmap);
         addChild(_expTxt);
         if(_exploitTxt)
         {
            addChild(_exploitTxt);
         }
      }
      
      private function addExploitTxt() : void
      {
         _exploitNumTxt = new ExpTotalNums(1);
         PositionUtils.setPos(_exploitNumTxt,"experience.TotalItemNumTxtPos");
         _exploitNumTxt.maxValue = 200000;
         _exploitNumTxt.y = _exploitNumTxt.y + 34;
         addChild(_exploitNumTxt);
      }
      
      protected function addTxt() : void
      {
         _expNumTxt = new ExpTotalNums(0);
         PositionUtils.setPos(_expNumTxt,"experience.TotalItemNumTxtPos");
         _expNumTxt.maxValue = 200000;
         if(GameControl.Instance.Current.roomType != 0 && GameControl.Instance.Current.roomType != 1 && GameControl.Instance.Current.roomType != 16 && GameControl.Instance.Current.roomType != 120)
         {
            _expNumTxt.y = _expNumTxt.y + 17;
         }
         addChild(_expNumTxt);
         if(EnthrallManager.getInstance().isEnthrall && TimeManager.Instance.totalGameTime >= EnthrallManager.STATE_3)
         {
            addChild(_enthrallBit);
         }
      }
      
      public function playGreenLight() : void
      {
         if(_exploitNumTxt != null)
         {
            _exploitNumTxt.playLight();
            SoundManager.instance.play("146");
         }
      }
      
      public function playRedLight() : void
      {
         if(_expNumTxt != null)
         {
            _expNumTxt.playLight();
            SoundManager.instance.play("146");
         }
      }
      
      public function updateTotalExp(param1:Number) : void
      {
         if(_expNumTxt == null)
         {
            addTxt();
         }
         _expNumTxt.setValue(param1);
      }
      
      public function updateTotalExploit(param1:Number) : void
      {
         if(GameControl.Instance.Current && GameControl.Instance.Current.roomType != 0 && GameControl.Instance.Current.roomType != 1 && GameControl.Instance.Current.roomType != 120)
         {
            return;
         }
         if(!_exploitNumTxt)
         {
            addExploitTxt();
         }
         _exploitNumTxt.setValue(param1);
      }
      
      public function dispose() : void
      {
         if(_expTxt)
         {
            ObjectUtils.disposeObject(_expTxt);
            _expTxt = null;
         }
         if(_exploitTxt)
         {
            ObjectUtils.disposeObject(_exploitTxt);
            _exploitTxt = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_bitmap)
         {
            ObjectUtils.disposeObject(_bitmap);
            _bitmap = null;
         }
         if(_expNumTxt)
         {
            _expNumTxt.dispose();
            _expNumTxt = null;
         }
         if(_exploitNumTxt)
         {
            _exploitNumTxt.dispose();
            _exploitNumTxt = null;
         }
         if(_enthrallBit)
         {
            ObjectUtils.disposeObject(_enthrallBit);
         }
         _enthrallBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
