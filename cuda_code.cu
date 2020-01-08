#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <stdio.h>

extern "C"
cudaError_t cuda_main()
{
    printf("stau\n");
    // generate bunch random numbers on the host
    thrust::host_vector<int> h_vec(1 << 25);
    thrust::generate(h_vec.begin(), h_vec.end(), rand);

    printf("dua %ld %ld %ld\n", h_vec.size(), h_vec[20], h_vec[2000]);
    // transfer data to the device
    thrust::device_vector<int> d_vec = h_vec;

    printf("tiga\n");
    // sort data on the device (805 Mkeys/sec on GeForce GTX 480)
    thrust::sort(d_vec.begin(), d_vec.end());

    printf("empat\n");
    // transfer data back to host
    thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());

    printf("lima %ld %ld %ld\n", h_vec.size(), h_vec[20], h_vec[2000]);
    return cudaGetLastError();
}
