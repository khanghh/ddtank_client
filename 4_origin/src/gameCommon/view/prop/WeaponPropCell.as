package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class WeaponPropCell extends PropCell
   {
       
      
      private var _countField:FilterFrameText;
      
      public function WeaponPropCell(shortcutKey:String, mode:int)
      {
         super(shortcutKey,mode);
         this.setGrayFilter();
      }
      
      private static function creatDeputyWeaponIcon(templateId:int) : Bitmap
      {
         var _loc2_:* = templateId;
         if(17001 !== _loc2_)
         {
            if(17002 !== _loc2_)
            {
               if(17101 !== _loc2_)
               {
                  if(17005 !== _loc2_)
                  {
                     if(17007 !== _loc2_)
                     {
                        if(17100 !== _loc2_)
                        {
                           if(17000 !== _loc2_)
                           {
                              if(17010 !== _loc2_)
                              {
                                 if(17003 !== _loc2_)
                                 {
                                    if(17004 !== _loc2_)
                                    {
                                       if(17200 !== _loc2_)
                                       {
                                          if(17006 !== _loc2_)
                                          {
                                             if(17011 !== _loc2_)
                                             {
                                                if(17012 !== _loc2_)
                                                {
                                                   if(17013 !== _loc2_)
                                                   {
                                                      if(17015 !== _loc2_)
                                                      {
                                                         return null;
                                                      }
                                                      return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop17015Asset");
                                                   }
                                                   return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop17013Asset");
                                                }
                                                return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop17012Asset");
                                             }
                                             return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop50Asset");
                                          }
                                          return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop42Asset");
                                       }
                                       return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop41Asset");
                                    }
                                    return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop32Asset");
                                 }
                                 return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop31Asset");
                              }
                           }
                           return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop36Asset");
                        }
                     }
                     addr25:
                     return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop35Asset");
                  }
                  §§goto(addr25);
               }
            }
            return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop30Asset");
         }
         return ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop29Asset");
      }
      
      override public function setPossiton(x:int, y:int) : void
      {
         super.setPossiton(x,y);
         this.x = _x;
         this.y = _y;
      }
      
      override protected function drawLayer() : void
      {
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _countField = ComponentFactory.Instance.creatComponentByStylename("game.PropCell.CountField");
         addChild(_countField);
      }
      
      public function setCount(count:int) : void
      {
         _countField.text = count.toString();
         _countField.x = _back.width - _countField.width;
         _countField.y = _back.height - _countField.height;
      }
      
      override public function set info(val:PropInfo) : void
      {
         var bitmap:* = null;
         ShowTipManager.Instance.removeTip(this);
         _info = val;
         var asset:DisplayObject = _asset;
         if(_info != null)
         {
            if(_info.Template.CategoryID != 17 && _info.Template.CategoryID != 31)
            {
               bitmap = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _info.Template.Pic + "Asset");
            }
            else
            {
               bitmap = creatDeputyWeaponIcon(_info.TemplateID);
            }
            if(bitmap)
            {
               bitmap.smoothing = true;
               var _loc4_:int = 3;
               bitmap.y = _loc4_;
               bitmap.x = _loc4_;
               _loc4_ = 32;
               bitmap.height = _loc4_;
               bitmap.width = _loc4_;
               addChildAt(bitmap,getChildIndex(_fore));
            }
            _asset = bitmap;
            _tipInfo.info = _info.Template;
            _tipInfo.shortcutKey = _shortcutKey;
            ShowTipManager.Instance.addTip(this);
            buttonMode = true;
         }
         else
         {
            _countField.text = "";
            buttonMode = false;
         }
         if(asset != null)
         {
            ObjectUtils.disposeObject(asset);
            asset = null;
         }
         _countField.visible = _info != null || _asset != null;
      }
      
      override public function useProp() : void
      {
         if(_info || _asset)
         {
            dispatchEvent(new MouseEvent("click"));
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_countField);
         _countField = null;
         super.dispose();
      }
   }
}
