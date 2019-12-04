package im.shimo.navigators;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.coordinatorlayout.widget.CoordinatorLayout;

/**
 * Created by jiang on 2019-11-28
 */

public class SceneStackRootView extends CoordinatorLayout implements FixFresco {

    public SceneStackRootView(@NonNull Context context) {
        super(context);
    }


    private boolean mIsDisableSetVisibility = false;

    @Override
    public void disableSetVisibility() {
        mIsDisableSetVisibility = true;
    }

    @Override
    public void enableSetVisibility() {
        mIsDisableSetVisibility = false;
    }

    @Override
    public boolean isDisableSetVisibility() {
        return mIsDisableSetVisibility;
    }

    @Override
    public void setVisibility(int visibility) {
        if (!mIsDisableSetVisibility){
            super.setVisibility(visibility);
        }
    }


}