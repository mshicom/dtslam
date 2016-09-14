#ifndef ROSDATASOURCE_H
#define ROSDATASOURCE_H


#include "ImageDataSource.h"

#include <rosbag/bag.h>
#include <rosbag/view.h>


namespace dtslam
{
class RosDataSource : public ImageDataSource
{
public:
    RosDataSource(void);
    ~RosDataSource(void);

    bool open(const std::string &bagFile, const std::string &imageTopic);
    void close(void);

    void dropFrames(int count);
    bool update(void);
protected:
    rosbag::Bag mbag;
    rosbag::View *mpview;
    rosbag::View::iterator mit;

};

}
#endif // ROSDATASOURCE_H
